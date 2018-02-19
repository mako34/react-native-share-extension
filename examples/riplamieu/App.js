/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */

import React, { Component } from 'react';
import {
  Platform,
  StyleSheet,
  Text,
  View,
  Button
} from 'react-native';

import ShareExtension from 'react-native-share-extension'


const instructions = Platform.select({
  ios: 'Press Cmd+R to reload,\n' +
    'Cmd+D or shake for dev menu',
  android: 'Double tap R on your keyboard to reload,\n' +
    'Shake or press menu button for dev menu',
});

type Props = {};
export default class App extends Component<Props> {

  constructor(props, context) {
    super(props, context)
    this.state = {
      isOpen: true,
      type: '',
      value: '',
      origin: 'JS',
    }
  }

  async componentDidMount() {
    try {
      const { type, value, origin } = await ShareExtension.data()
      this.setState({
        type,
        value,
        origin
      })
    } catch(e) {
      console.log('errrr', e)
    }
  }


closeExtensionComposer() {
  console.log("righteous 1")
  ShareExtension.close()
}

  render() {
    return (
      <View style={styles.container}>
        <Text style={styles.welcome}>
          SS9
        </Text>
        <Text style={styles.instructions}>
          tkt
        </Text>

        <Button onPress={ this.closeExtensionComposer } title="Cerradlo" />

         <Text>origin: { this.state.origin }</Text>
         <Text>type: { this.state.type }</Text>
         <Text>value: { this.state.value }</Text>
         

      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF',
  },
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
  },
  instructions: {
    textAlign: 'center',
    color: '#333333',
    marginBottom: 5,
  },
});
