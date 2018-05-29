import React from "react"
import PropTypes from "prop-types"
import RecipeForm from "./RecipeForm"

import styles from '../styles/components'

class StepRecipe extends React.Component {

  handleComplete = (recipe) => {
    this.props.onComplete(recipe.name)
  }

  render () {
    return (
      <div className={"columns " + (this.props.activityStatus == 'pending' ? styles.inactiveStep : '' )}>
        <div className="column is-5">
          <p className="is-size-5">
            <span className="numberCircle">2</span>
            Let's add a recipe
          </p>
        </div>
        <div className="column is-7">
          {this.props.activityStatus == 'active' &&
            <div>
              <p className="is-size-5">Alexa will be able to respond to questions about a recipe's <strong>ingredients</strong> and it's <strong>steps</strong>.</p>
              <br/>
              <RecipeForm mode="wizard" onComplete={this.handleComplete}/>
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

StepRecipe.propTypes = {
  activityStatus: PropTypes.string,
  onComplete: PropTypes.func
}

export default StepRecipe