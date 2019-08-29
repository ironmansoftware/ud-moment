import React from 'react';
import Moment from 'react-moment';
import 'moment-timezone';

export default class UDMoment extends React.Component {
  render() {
    return (
      <Moment {...this.props } interval={0}/>
    );
  }
}