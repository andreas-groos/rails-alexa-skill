import React from "react"
import PropTypes from "prop-types"

import axios from 'axios'
import Disaster from './Disaster'

class SignIn extends React.Component {
  constructor(props) {
    super(props)

    this.state = {
      email: '',
      password: '',
      failedAttempt: false,
      disasterState: false
    }

  }

  emailInput = (event) => {
    this.setState({email: event.target.value})
  }

  passwordInput = (event) => {
    this.setState({password: event.target.value})
  }

  handleSubmit = (event) => {
    event.preventDefault()
    axios.post('/signin', {
      email: this.state.email,
      password: this.state.password
    })
    .then((response) => {
      if ( response.data.success ) {
        /* Things went well.  The user is signed in with a session, so let's reload the page for now,
             and maybe one day load up another component all fancy.
        */
        location.reload()
      } else {
        /* There's a problem with the credentials.  So let's print a message and let them try again. */
        this.setState({failedAttempt: true})
      }
    })
    .catch((error) => {
      this.setState({disasterState: true})
    })
  }


  render () {

    if (this.state.disasterState) return (<Disaster/>)

    return (
      <div>
        { this.state.failedAttempt &&
          <div class="is-error">
            Invalid credentials.
          </div>
        }

        <form className="" onSubmit={this.handleSubmit}>
          <div className="field">
            <label className="label">Email Address</label>
            <div className="control has-icons-left">
              <input className="input is-large"
                     type="email"
                     placeholder=""
                     value={this.state.email}
                      onChange={this.emailInput}
              />
              <span className="icon is-small is-left icon-embedded">
                <svg className="icon__cnt">
                  <use xmlnsXlink="http://www.w3.org/1999/xlink" xlinkHref="#ei-envelope-icon"></use>
                </svg>
              </span>

            </div>
          </div>

          <div className="field">
            <label className="label">Password</label>
            <div className="control has-icons-left">
              <input className="input is-large"
                     type="password"
                     placeholder=""
                     value={this.state.password}
                     onChange={this.passwordInput}
              />
              <span className="icon is-small is-left icon-embedded">
                <svg className="icon__cnt">
                  <use xmlnsXlink="http://www.w3.org/1999/xlink" xlinkHref="#ei-lock-icon"></use>
                </svg>
              </span>
            </div>
          </div>

          <input type="submit" className="button is-success is-large" value="Sign In" />
        </form>
        
      </div>
    )
  }
}

export default SignIn