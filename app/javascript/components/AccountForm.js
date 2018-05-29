import React from "react"
import PropTypes from "prop-types"

import SignIn from './SignIn'
import SignUp from './SignUp'

//import styles from '../styles/components'

class AccountForm extends React.Component {

  constructor(props) {
    super(props)

    this.state = {
      mode: props.mode,
    }
  }

  tabClick = (newMode) => {
    this.setState({mode: newMode})
  }

  handleComplete = (codeword) => {
    this.props.onComplete(codeword)
  }

  render () {

    const form = this.state.mode == 'signin' ? (
      <SignIn />
    ) : (
      <SignUp onComplete={this.handleComplete}/>
    )

    return (
      <div>
        <div className="tabs is-medium">
          <ul>
            <li className={this.state.mode == 'signup' ? 'is-active' : ''}>
              <a onClick={() => this.tabClick('signup')}>Start a new account</a>
            </li>
            <li  className={this.state.mode == 'signin' ? 'is-active' : ''}> 
              <a onClick={() => this.tabClick('signin')}>Already have an account?</a>
            </li>
          </ul>
        </div>
        <div>
          {form}
        </div>
      </div>
    )
  }
}

AccountForm.propTypes = {
  mode: PropTypes.string,
  onComplete: PropTypes.func
}
export default AccountForm
