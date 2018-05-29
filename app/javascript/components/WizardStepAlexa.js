import React from "react"
import PropTypes from "prop-types"

import styles from '../styles/components'

class StepAlexa extends React.Component {

  handleComplete = () => {
    this.props.onComplete()
  }

  render () {
    return (
      <div className={"columns " + (this.props.activityStatus == 'pending' ? styles.inactiveStep : '' )}>
        <div className="column is-5">
          <p className="is-size-5">
            <span className="numberCircle">3</span>
            Connect Alexa
          </p>
        </div>
        <div className="column is-7">
          {this.props.activityStatus == 'active' &&
          <div>
            <p className="is-size-4">Please say the following commands...</p>
            <br/>
            <p className="is-size-5">Alexa, enable skill <strong>repeat my recipes</strong></p>
            <br/>
            <p className="is-size-5">Alexa, load repeat my recipes</p>
            <br/>
            <p className="is-size-5">Alexa, my voice is my passport, <strong>{this.props.codeword}</strong></p>
            <br/>
            <a className="button is-link"
               onClick={this.handleComplete}
               id="alexa-link-success-button">Click Here After Link Successful</a>

          </div>
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

StepAlexa.propTypes = {
  activityStatus: PropTypes.string,
  onComplete: PropTypes.func
}
export default StepAlexa