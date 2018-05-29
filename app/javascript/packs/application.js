
import React from 'react'
import ReactDOM from 'react-dom'
import axios from 'axios'

import '../styles/bulma'
import '../styles/general.css'
import '../styles/animate.css'

import Wizard from '../components/Wizard'
import RecipeList from '../components/RecipeList'

document.addEventListener('DOMContentLoaded', () => {

  let token = document.getElementById('csrf-token-body').getAttribute('token')
  axios.defaults.headers.common['X-CSRF-Token'] = token
  axios.defaults.headers.common['Accept'] = 'application/json'

  let wizardNode = document.getElementById("wizard-container")
  if (wizardNode) ReactDOM.render(<Wizard mode="signup"/>, wizardNode)

  let recipeListNode = document.getElementById("recipe-list-container")
  if (recipeListNode) ReactDOM.render(<RecipeList />, recipeListNode)

  /* let moodvideoNode = document.getElementById("moodvideo")
  if (moodvideoNode) moodvideoNode.playbackRate = 0.4; */
})