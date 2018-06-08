import React from "react"

const Disaster = (props) => {
   return (
      <div>
        <div style={{height: '75px', width: '75px'}}
             className="is-large icon plan-icon">
          <svg className="icon__cnt icon-danger">
            <use xmlnsXlink="http://www.w3.org/1999/xlink" xlinkHref="#ei-exclamation-icon"></use>
          </svg>
        </div>
        <p className="is-size-5">{props.message}</p>
      </div>
    )
}

export default Disaster
