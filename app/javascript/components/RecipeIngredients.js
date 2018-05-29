import React from "react"
import PropTypes from "prop-types"

class RecipeIngredients extends React.Component {

  constructor(props) {
    super(props)

    this.state = {
      pendingIngredientName: '',
      pendingIngredientQty: ''
    }

    this.ingredientNameField = React.createRef()
  }

  addIngredient = () => {

    /* poor man's validation TODO*/
    if (this.state.pendingIngredientName.length < 2) return true

    let qty = this.state.pendingIngredientQty
    if (qty == "") qty = "one"
    
    this.props.addIngredient(this.state.pendingIngredientName, qty)

    this.setState({
      pendingIngredientName: '',
      pendingIngredientQty: ''
    })

    this.ingredientNameField.current.focus()
  }

  removeIngredient = (idx) => {
    this.props.removeIngredient(idx)
  }

  pendingIngredientNameInput = (event) => {
    this.setState({pendingIngredientName: event.target.value})
  }

  pendingIngredientQtyInput = (event) => {
    this.setState({pendingIngredientQty: event.target.value})
  }

  render () {
    return (
      <table className="table is-striped is-fullwidth">
        <thead>
          <tr>
            <th>Ingredient Name</th>
            <th>Quantity</th>
            <th></th>
          </tr>
        </thead>
        <tbody>
          {this.props.ingredients.map( (ingredient, idx) =>
            <tr key={idx}>
              <td>{ingredient.name}</td>
              <td>{ingredient.quantity}</td>
              <td>
                <span style={{cursor: 'pointer'}}
                      className="icon is-large is-left has-text-success"
                      onClick={() => {this.removeIngredient(idx)}}
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
              <input className="input is-large "
                      value={this.state.pendingIngredientName}
                      type="text"
                      onChange={this.pendingIngredientNameInput}
                      ref={this.ingredientNameField}
                      id="pending-ingredient-name"
                      onKeyPress={event => {
                        if (event.key === 'Enter') {
                          event.preventDefault()
                          this.addIngredient()
                        }
                      }}
                      placeholder="e.g. Salt"/>
            </td>
            <td>
              <input className="input is-large"
                      value={this.state.pendingIngredientQty}
                      type="text"
                      onChange={this.pendingIngredientQtyInput}
                      placeholder="e.g. 1 teaspoon"
                      id="pending-ingredient-quantity"
                      onKeyPress={event => {
                        if (event.key === 'Enter') {
                          event.preventDefault()
                          this.addIngredient()
                        }
                      }}
              />
            </td>
            <td>
              <a style={{cursor: 'pointer'}}
                    className="icon is-large is-left has-text-success"
                    onClick={this.addIngredient}
                    id="pending-ingredient-plus"
              >
                <svg className="icon__cnt">
                  <use xmlnsXlink="http://www.w3.org/1999/xlink" xlinkHref="#ei-plus-icon"></use>
                </svg>
              </a>
            </td>
          </tr>
        </tbody>
      </table>
    )
  }
}

RecipeIngredients.propTypes = {
  removeIngredient: PropTypes.func,
  addIngredient: PropTypes.func,
  ingredients: PropTypes.array
}

export default RecipeIngredients
