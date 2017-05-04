import React from 'react';

export default class Plane extends React.Component {

  renderTakeOffnButton() {
    if (this.props.plane.state == 'in_shelter') {
      return (<a  className="button" onClick={(e) => this.props.onClick(e)}>На взлет</a>)
    }
  }

  render() {
    return(
    <tr>
      <td>{this.props.plane.name}</td>
      <td>{this.props.plane.human_state}</td>
      <td>{this.props.plane.history_state.join("\n")}</td>
      <td>{ this.renderTakeOffnButton() }</td>
    </tr>
    );
  }
}