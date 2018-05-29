import React from "react"
import PropTypes from "prop-types"

import styles from '../styles/components'

class StepPractice extends React.Component {

  handleComplete = () => {
    this.props.onComplete()
  }

  render () {
    return (
      <div className={"columns " + (this.props.activityStatus == 'pending' ? styles.inactiveStep : '' )}>
        <div className="column is-5">
          <p className="is-size-5">
            <span className="numberCircle">4</span>
            Practice
          </p>
        </div>
        <div className="column is-7">
          {this.props.activityStatus == 'active' &&
          <div>
            <p className="is-size-4">Please say the following commands...</p>
            <p>"Alexa, load repeat my recipes"</p>
            <br/>
            <p>"Alexa, list my recipes"</p>
            <br/>
            <p>{`Alexa what are the ingredients in my ${this.props.recipename} recipe`}</p>
            <br/>
            <a className="button is-link" onClick={this.handleComplete} id="wizard-complete-button">Ok, all done.</a>

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
    );
  }
}

StepPractice.propTypes = {
  activityStatus: PropTypes.string,
  onComplete: PropTypes.func
}
export default StepPractice