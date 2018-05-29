import React from "react"
import PropTypes from "prop-types"
import axios from 'axios'

import Disaster from './Disaster'

class Recipe extends React.Component {

  constructor(props) {
    super(props)

    this.state = {
      disasterState: false
    }
  }

  render () {

    if (this.state.disasterState) return (<Disaster/>)

    return (
      <div className="card recipe-card">
        <header className="card-header">
          <p className="card-header-title">
          {this.props.recipe.name}
          </p>
        </header>
        <div className="card-content">
          <div className="content">
            {this.props.recipe.ingredients.map( (ingredient, idx) =>
                <div key={ingredient.id}>
                  <p><strong>{ingredient.quantity}</strong> {ingredient.name}</p>
                </div>
              )
            }
            <br/>
            <time>{this.props.recipe.pretty_day}</time>
          </div>
        </div>
        <footer className="card-footer">
          <a href="#" className="card-footer-item" onClick={() => this.props.handleEdit(this.props.recipe)}>Edit</a>
          <a href="#" className="card-footer-item" onClick={() => this.props.handleDelete(this.props.recipe)}>Delete</a>
        </footer>
      </div>
    )
  }
}

Recipe.propTypes = {
  recipe: PropTypes.object
}
export default Recipe