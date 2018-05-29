import React from "react"
import ReactDOM from 'react-dom'
import PropTypes from "prop-types"
import Recipe from './Recipe'
import RecipeForm from './RecipeForm'
import Disaster from './Disaster'
import axios from 'axios'

class RecipeList extends React.Component {

  constructor(props) {
    super(props)

    this.state = {
      recipes: [],
      activeRecipe: null,
      disasterState: false
    }

    this.recipeFormElement = React.createRef();
  }

  componentDidMount() {
    this.reloadRecipes()
  }

  componentDidUpdate() {
    /*
    const element = document.getElementById(this.state.media);
    element.scrollIntoView({behavior: 'smooth'});
    */
    if (this.recipeFormElement.current) {
      ReactDOM.findDOMNode(this.recipeFormElement.current).scrollIntoView({
        alignToTop: true,
        behavior: 'smooth'
      })
    }
  }

  inGroupsOf(arr, n) {
    return arr.slice(0, (arr.length + n - 1)/n | 0).map((c, i) => arr.slice(n * i, n * i + n))
  }

  newRecipeForm = () => {
    this.setState({
      activeRecipe: {
        id: null,
        name: '',
        ingredients: [],
        steps: []
      }
    })
  }

  recipeFormCompleted = (recipe) => {
    this.reloadRecipes()
    this.setState({ activeRecipe: null })
  }

  handleEdit = (recipe) => {
    this.setState({ activeRecipe: recipe })
  }

  handleDelete = (recipe) => {
    axios.delete(`/recipe/${recipe.id}`)
    .then((response) => {
      if ( response.data.success ) {
        this.reloadRecipes()
      } else {
        this.setState({disasterState: true})
      }
    })
    .catch((error) => {
      this.setState({disasterState: true})
    })
  }

  reloadRecipes = () => {
    axios.get('/recipe', {})
    .then((response) => {
      if ( response.data.success ) {
        this.setState({recipes: response.data.recipes})
      } else {
        this.setState({disasterState: true})
      }
    })
    .catch((error) => {
      this.setState({disasterState: true})
    })
  }

  render () {

    if (this.state.disasterState) return (<Disaster/>)

    return (
      <div id="recipe-list">
        {this.state.activeRecipe == null &&
          <div style={{cursor: 'pointer', position: 'fixed', bottom: '25px', right: '25px', height: '75px', width: '75px'}}
              className="is-large icon plan-icon"
              onClick={this.newRecipeForm}>
            <svg className="icon__cnt icon-success">
              <use xmlnsXlink="http://www.w3.org/1999/xlink" xlinkHref="#ei-plus-icon"></use>
            </svg>
          </div>
        }

        {this.state.activeRecipe == null && this.inGroupsOf(this.state.recipes, 3).map((chunk, idx) =>
          <div key={`recipe-col-${idx}`} className="columns">
            {chunk.map((recipe, recipeidx) =>
              <div key={`recipe-${recipe.id}`} className="column is-4">
                <Recipe recipe={recipe} handleEdit={this.handleEdit} handleDelete={this.handleDelete}/>
              </div>
            )}
          </div>
        )}

        {this.state.activeRecipe != null &&

            <div ref={this.recipeFormElement}>
              <RecipeForm recipe={this.state.activeRecipe}
                          onComplete={this.recipeFormCompleted}

              />
            </div>
        }
      </div>
    )
  }
}

export default RecipeList
