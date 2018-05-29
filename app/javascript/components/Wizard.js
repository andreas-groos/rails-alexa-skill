import React from "react"
import PropTypes from "prop-types"

import StepAccount from './WizardStepAccount'
import StepRecipe from './WizardStepRecipe'
import StepAlexa from './WizardStepAlexa'
import StepPractice from './WizardStepPractice'

class Wizard extends React.Component {

  constructor(props) {
    super(props)

    this.state = {
      accountStepStatus: 'active',
      recipeStepStatus: 'pending',
      alexaStepStatus: 'pending',
      practiceStepStatus: 'pending',
      codeword: '',
      recipename: ''
    }
  }

  handleAccountStepComplete = (codeword) => {
    this.setState({
      accountStepStatus: 'complete',
      recipeStepStatus: 'active',
      codeword: codeword
    })
  }

  handleRecipeStepComplete = (recipename) => {
    this.setState({
      recipeStepStatus: 'complete',
      alexaStepStatus: 'active',
      recipename: recipename
    })
  }

  handleAlexaStepComplete = () => {
    this.setState({
      alexaStepStatus: 'complete',
      practiceStepStatus: 'active'
    })
  }

  handlePracticeStepComplete = () => {
    location.reload()
  }

  render () {
    return (
      <div className="section" id="wizard-section">
        <div className="container">
          <StepAccount activityStatus={this.state.accountStepStatus} 
                      onComplete={this.handleAccountStepComplete}
          />
          <StepRecipe activityStatus={this.state.recipeStepStatus}
                      onComplete={this.handleRecipeStepComplete}
          />
          <StepAlexa activityStatus={this.state.alexaStepStatus}
                     onComplete={this.handleAlexaStepComplete}
                     codeword={this.state.codeword}
          />
          <StepPractice activityStatus={this.state.practiceStepStatus}
                        onComplete={this.handlePracticeStepComplete}
                        recipename={this.state.recipename}
          />
        </div>
      </div>
    )
  }
}

export default Wizard
