import React from "react"
import PropTypes from "prop-types"
import axios from 'axios'

class Disaster extends React.Component {

  render () {
    return (
      <div>
        <div style={{height: '75px', width: '75px'}}
             className="is-large icon plan-icon">
          <svg className="icon__cnt icon-danger">
            <use xmlnsXlink="http://www.w3.org/1999/xlink" xlinkHref="#ei-exclamation-icon"></use>
          </svg>
        </div>
        <p className="is-size-5">{this.props.message}</p>
      </div>
    )
  }
}

Disaster.defaultProps = {
  message: 'Stranger'
}

Disaster.propTypes = {
  message: PropTypes.string
}

export default Disaster