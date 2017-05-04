import React from 'react';
import axios from 'axios';

import Plane from './plane';



export default class Planes extends React.Component {

  constructor(props, context) {
    super(props, context);
    this.state = {planes: this.props.planes};
    this.defaultProps = {planes: []};
  }


  takeoffClick(plane,e) {
    e.preventDefault();
    axios({
      method:'put',
      url:'/api/planes/state/'+plane.id+'.json'
    })
      .then(function(response) {});
  }

  addToPlane(e) {
    e.preventDefault();
    const self = this;
    axios({
      method:'post',
      url:'/api/planes.json'
    })
      .then(function(result) {
        const planes = self.state.planes;
        planes.unshift(result.data);
        self.setState({planes: planes});
      });
  }


  componentWillMount() {
    if (typeof App !== 'undefined'){
      const self = this;
      App.cable.subscriptions.create('TrafficChannel', {
        received: function(plane) {
          const planes =  self.state.planes;
          const foundIndex = planes.findIndex(x => x.id == plane.id);
          planes[foundIndex] = plane;
          self.setState({planes: planes});
        }
      });
    }

  }

  render() {
    return (
      <div className="plane-list">
        <div className="add-plane"><a  className="button" onClick={(e) => this.addToPlane(e)}>Добавить самолет в ангар</a></div>
        <table className="table">
          <thead>
            <tr><th>Самолет</th><th>Статус</th><th>История</th><th>Действие</th></tr>
          </thead>
          <tbody>
          { this.state.planes.map((plane) =>
            <Plane key={plane.id} plane={plane} onClick={(e) => this.takeoffClick(plane,e)} />
          )
          }
          </tbody>
        </table>

      </div>
    )
  }

}