import React from "react"
import PropTypes from "prop-types"

import axios from 'axios'
import Disaster from './Disaster'

class SignUp extends React.Component {
  
  constructor(props) {
    super(props)

    this.state = {
      name: '',
      email: '',
      password: '',
      nameErrors: [],
      emailErrors: [],
      passwordErrors: [],
      signupSuccessful: false,
      disasterState: false
    }
  }

  nameInput = (event) => {
    this.setState({name: event.target.value})
  }

  emailInput = (event) => {
    this.setState({email: event.target.value})
  }

  passwordInput = (event) => {
    this.setState({password: event.target.value})
  }

  nameValidationCssClass = () => {
    if (this.state.nameErrors.length > 0) return "is-danger"
    if (this.state.name.length > 0) return "is-success"
  }

  emailValidationCssClass = () => {
    if (this.state.emailErrors.length > 0) return "is-danger"

    /* found this on the back of a cracker jacks box. */
    let re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
    if (re.test(this.state.email.toLowerCase())) return "is-success"
  }

  passwordValidationCssClass = () => {
    if (this.state.passwordErrors.length > 0) return "is-danger"
    if (this.state.password.length > 3) return "is-success"
  }

  handleSubmit = (event) => {
    event.preventDefault()
    axios.post('/account/signup', {
      name: this.state.name,
      email: this.state.email,
      password: this.state.password
    })
    .then((response) => {
      if ( response.data.success ) {
        /* Things went well.  An account was created.  We are ready to mark the component state to success and
             call the callback to signal success to a parent. */
        this.setState({signupSuccessful: true})
        this.props.onComplete(response.data.codeword)
      } else {
        /* No account was created.  We assume this is because a server side validation failed, so as long as there
              are details about the server side validation issues, we highlight the fields.  Otherwise, we're not sure
              what happened and should raise an error to trigger disaster state. */
        if (response.data.errors.name) {
          this.setState({nameErrors: response.data.errors.name})
        }

        if (response.data.errors.email) {
          this.setState({emailErrors: response.data.errors.email})
        }

        if (response.data.errors.password) {
          this.setState({passwordeErrors: response.data.errors.password})
        }
      }
    })
    .catch((error) => {
      console.log(error)
      this.setState({disasterState: true})
    })
  }

  render () {

    if (this.state.disasterState) return (<Disaster/>)

    if (this.state.signupSuccessful) {
      return (
        <div>
          Success.
        </div>
      )
    } 

    return (
      <div>
        <form className="" onSubmit={this.handleSubmit}>
          <div className="field">
            <label className="label">What is your name?</label>
            <div className="control has-icons-left">
              <input className={"input is-large " + (this.nameValidationCssClass())}
                     type="text"
                     placeholder="e.g. Monica Geller"
                     value={this.state.name}
                     id="signup-name"
                     onChange={this.nameInput}
              />

              <span className="icon is-small is-left icon-embedded">
                <svg className="icon__cnt">
                  <use xmlnsXlink="http://www.w3.org/1999/xlink" xlinkHref="#ei-user-icon"></use>
                </svg>
              </span>
            </div>
            {this.state.nameErrors.map(errorMsg =>
              <p key={errorMsg} className="help is-danger">{errorMsg}</p>
            )}
          </div>

          <div className="field">
            <label className="label">Email Address</label>
            <div className="control has-icons-left has-icons-right">
              <input className={"input is-large " + (this.emailValidationCssClass())}
                     name="x"
                     type="text"
                     id="signup-email"
                     placeholder="e.g. me@website.com"
                     value={this.state.email} 
                     onChange={this.emailInput}
              />

              <span className="icon is-small is-left icon-embedded">
                <svg className="icon__cnt">
                  <use xmlnsXlink="http://www.w3.org/1999/xlink" xlinkHref="#ei-envelope-icon"></use>
                </svg>
              </span>

              {this.state.emailErrors.length > 0  &&
                 <span className="icon is-small is-right">
                   <i className="fas fa-exclamation-triangle"></i>
                 </span>
              }

            </div>
            {this.state.emailErrors.map(errorMsg =>
              <p key={errorMsg} className="help is-danger">{errorMsg}</p>
            )}

          </div>

          <div className="field">
            <label className="label">Choose a Password</label>
            <div className="control has-icons-left">
              <input className={"input is-large " + (this.passwordValidationCssClass())}
                     type="password"
                     id="signup-password"
                     placeholder="we're pretty low security around here."
                     value={this.state.password}
                     onChange={this.passwordInput}
              />

              <span className="icon is-small is-left icon-embedded">
                <svg className="icon__cnt">
                  <use xmlnsXlink="http://www.w3.org/1999/xlink" xlinkHref="#ei-lock-icon"></use>
                </svg>
              </span>

              <span className="icon is-small is-right">
                <i className="fas fa-exclamation-triangle"></i>
              </span>
            </div>
            {this.state.passwordErrors.map(errorMsg =>
              <p key={errorMsg} className="help is-danger">{errorMsg}</p>
            )}
          </div>

          <input type="submit" className="button is-success is-large" value="Create Account" />
        </form>
        
      </div>
    )
  }
}

SignUp.propTypes = {
  onComplete: PropTypes.func
}

export default SignUp