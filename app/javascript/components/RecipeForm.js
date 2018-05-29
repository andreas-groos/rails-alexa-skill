import React from "react"
import PropTypes from "prop-types"

import RecipeIngredients from './RecipeIngredients'
import RecipeSteps from './RecipeSteps'
import Disaster from './Disaster'

import axios from 'axios'

//import styles from '../styles/components'

class RecipeForm extends React.Component {

  constructor(props) {
    super(props)

    this.state = {
      mode: props.mode,
      recipeId: null,
      name: '',
      errorMsg: '',
      ingredients: [],
      steps: [],
      disasterState: false
    }

    if (props.recipe) {
      if (props.recipe.id) this.state.mode = 'edit'
      this.state.recipeId = props.recipe.id
      this.state.name = props.recipe.name
      this.state.ingredients = props.recipe.ingredients
      this.state.steps = props.recipe.steps
    }
  }

  handleComplete = (e) => {
    this.props.onComplete()
  }

  nameInput = (event) => {
    this.setState({name: event.target.value})
  }

  nameValidationCssClass = () => {
    if (this.state.errorMsg.length > 0 && this.state.name.length == 0 ) return 'is-danger'
    if (this.state.name.length > 0) return "is-success"
  }

  addIngredient = (name, qty) => {
    this.setState({
      ingredients: this.state.ingredients.concat(
        [{name: name, quantity: qty}]
      )
    })
  }

  removeIngredient = (idx) => {
    let newIngredients = this.state.ingredients.slice(0)
    newIngredients.splice(idx, 1)
    this.setState({
      ingredients: newIngredients
    })
  }

  addStep = (description) => {
    this.setState({
      steps: this.state.steps.concat(
        [{description: description}]
      )
    })
  }
  removeStep = (idx) => {
    let newSteps = this.state.steps.slice(0)
    newSteps.splice(idx, 1)
    this.setState({
      steps: newSteps
    })
  }

  handleSubmit = (event) => {
    event.preventDefault()

    let params = {
      id: this.state.recipeId,
      name: this.state.name,
      ingredients: this.state.ingredients,
      steps: this.state.steps
    }

    var prom
    if (this.state.recipeId) {
      prom = axios.put(`/recipe/${params.id}`, params)
    } else {
      prom = axios.post('/recipe', params)
    }

    prom.then((response) => {
      if ( response.data.success ) {
        this.props.onComplete({
          name: this.state.name,
          ingredients: this.state.ingredients,
          steps: this.state.steps
        })
      } else {
        this.setState({errorMsg: response.data.error})
      }
    })
    .catch((error) => {
      this.setState({disasterState: true})
    })
  }

  render () {

    if (this.state.disasterState) return (<Disaster/>)

    return (
      <div id="recipe-form">
        <form onSubmit={this.handleSubmit}>

          <div className="field">
            <h3 className="is-size-4">What do you call this recipe?</h3>
            <div className="control has-icons-left">
              <input className={"input is-large " + (this.nameValidationCssClass())}
                     type="text"
                     placeholder="e.g. My secret Guacamole"
                     value={this.state.name}
                     onChange={this.nameInput}
                     id="recipe-name"
                     onKeyPress={event => {
                      if (event.key === 'Enter') {
                        event.preventDefault()
                      }
                    }}
              />

              <span className="icon is-small is-left icon-embedded">
                <svg className="icon__cnt">
                  <use xmlnsXlink="http://www.w3.org/1999/xlink" xlinkHref="#ei-tag-icon"></use>
                </svg>
              </span>
            </div>
          </div>
          <br/>
          <p className="is-size-5">Great, let's add some ingredients.</p>
          <br/>
          <RecipeIngredients ingredients={this.state.ingredients}
                             addIngredient={this.addIngredient}
                             removeIngredient={this.removeIngredient} />

          <br/>
          <p className="is-size-5">Cool, now let's write down the steps.</p>
          <br/>

          <RecipeSteps steps={this.state.steps}
                       addStep={this.addStep}
                       removeStep={this.removeStep} />

          {this.state.errorMsg &&
            <p className="is-size-6 has-text-danger">{this.state.errorMsg}</p>
          }

          {this.state.mode != 'wizard' &&
            <button style={{float: 'right'}} className="button is-default is-large" onClick={this.props.onComplete}>Cancel</button>
          }
          <input type="submit" className="button is-success is-large" value={this.state.mode == 'edit' ? "Update Recipe" : "Save New Recipe"} />

        </form>

      </div>
    )
  }
}

RecipeForm.propTypes = {
  onComplete: PropTypes.func,
  recipe: PropTypes.object
}
export default RecipeForm