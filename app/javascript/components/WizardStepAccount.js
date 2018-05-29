import React from "react"
import PropTypes from "prop-types"

import AccountForm from './AccountForm'
import styles from '../styles/components'

class StepAccount extends React.Component {

  handleComplete = (codeword) => {
    this.props.onComplete(codeword)
  }

  render () {
    return (
      <div className={"columns " + (this.props.activityStatus == 'pending' ? styles.inactiveStep : '' )}>
        <div className="column is-5">
          <p className="is-size-5">
            <span className="numberCircle">1</span>
            Let's get an account to store your recipes in.
          </p>
        </div>
        <div className="column is-7">
          {this.props.activityStatus == 'active' &&
            <AccountForm mode="signup" onComplete={this.handleComplete}/>
          }
          {this.props.activityStatus == 'complete' &&
            <span className="icon is-large is-left icon-embedded icon-success">
              <svg className="icon__cnt">
                <use xmlnsXlink="http://www.w3.org/1999/xlink" xlinkHref="#ei-check-icon"></use>
              </svg>
            </span>
          }
        </div>
      </div>
    )
  }
}

StepAccount.propTypes = {
  activityStatus: PropTypes.string,
  onComplete: PropTypes.func
}
export default StepAccount
