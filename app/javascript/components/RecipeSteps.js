import React from "react"
import PropTypes from "prop-types"

class RecipeSteps extends React.Component {

  constructor(props) {
    super(props)

    this.state = {
      pendingStep: '',
    }

    this.stepField = React.createRef()
  }

  pendingStepInput = (event) => {
    this.setState({pendingStep: event.target.value})
  }

  addStep = () => {
    /* poor man's validation */
    if (this.state.pendingStep.length < 3) return true

    this.props.addStep(this.state.pendingStep)
    this.setState({pendingStep: ''})
    this.stepField.current.focus()
  }

  removeStep = (idx) => {
    this.props.removeStep(idx)
  }


  render () {
    return (
      <table className="table is-striped is-fullwidth">
        <thead>
          <tr>
            <th>Step Number</th>
            <th>Description</th>
            <th></th>
          </tr>
        </thead>
        <tbody>
          {this.props.steps.map((step, idx) =>
            <tr key={idx}>
              <td>{idx + 1}</td>
              <td>{step.description}</td>
              <td>
                <span style={{cursor: 'pointer'}}
                      className="icon is-large is-left icon-embedded has-text-success"
                      onClick={() => {this.removeStep(idx)}}
                >
                  <svg className="icon__cnt">
                    <use xmlnsXlink="http://www.w3.org/1999/xlink" xlinkHref="#ei-minus-icon"></use>
                  </svg>
                </span>
              </td>
            </tr>
          )}
          <tr>
            <td>
              {this.props.steps.length + 1}
            </td>
            <td>
              <input className="input is-large"
                      type="text"
                      placeholder="e.g. Dice a jalapeno"
                      ref={this.stepField}
                      id="pending-step-description"
                      value={this.state.pendingStep}
                      onChange={this.pendingStepInput}
                      onKeyPress={event => {
                        if (event.key === 'Enter') {
                          event.preventDefault()
                          this.addStep()
                        }
                      }}
              />
            </td>
            <td>
              <span className="icon is-large is-left icon-embedded has-text-success"
                    onClick={this.addStep}
                    id="pending-step-plus"
              >
                <svg className="icon__cnt">
                  <use xmlnsXlink="http://www.w3.org/1999/xlink" xlinkHref="#ei-plus-icon"></use>
                </svg>
              </span>
            </td>
          </tr>
        </tbody>
      </table>
    )
  }
}

RecipeSteps.propTypes = {
  addStep: PropTypes.func,
  removeStep: PropTypes.func,
  steps: PropTypes.array
}

export default RecipeSteps