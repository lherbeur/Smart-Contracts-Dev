
import React from 'react'
import ReactDOM from 'react-dom'
import { Vesting } from './contracts.js'

const vestingImplementation = () => {
  Vesting.setProvider(window.web3.currentProvider)
  Vesting.at('0xB3CF1d736F5cE199480ba750C2A3C42c78cB2B48').then((contract) => {
    vestingInstance = contract
    console.log(vestingInstance)
  })
  // Vesting.deployed().then(console.log)
}

let vestingInstance = {}

class Container extends React.Component {
  constructor () {
    super()
    this.state = {
      showScheduleForm: false,
      status: 'Idle',
      transactDetails: {}
    }
    this.transactDetails = []
  }
  toggleScheduleform () {
    this.setState({
      showScheduleForm: !this.state.showScheduleForm
    })
    console.log(this.state.showScheduleForm)
  }
  returnScheduleForm () {
    if (this.state.showScheduleForm) {
      return (<ScheduleForm
        setStatus={this.setStatus.bind(this)} toggleScheduleform={this.toggleScheduleform.bind(this)}
        updateTransactionDetails={this.updateTransactionDetails.bind(this)}
      />)
    }
  }
  signalTransacting () {
    if (this.state.status === 'transacting') {
      return (<div>Pending transaction. Please wait...</div>)
    }
  }
  setStatus (newStatusStr) {
    this.setState({
      status: newStatusStr
    })
  }
  renderTransactionDetails () {
    for (const detail in this.state.transactionDetails) {
      return (<TransactionDetail title={detail} value={this.state.transactionDetails[detail]} />)
    }
  }
  updateTransactionDetails (transactionDetails) {
    this.setState({
      transactionDetails
    })
  }
  render () {
    return (
      <div>
        <Button
          onClick={this.toggleScheduleform.bind(this)}
          text={this.state.showScheduleForm ? 'Hide form' : 'Create Schedule'}
        />
        {this.returnScheduleForm()}
        {this.signalTransacting()}
        {this.renderTransactionDetails()}
      </div>
    )
  }
}

class ScheduleForm extends React.Component {
  constructor () {
    super()
    this.state = {
      address: '',
      name: '',
      start: '',
      end: '',
      cliff: '',
      value: ''
    }
  }
  setValue (type, value) {
    this.setState({
      [type]: value
    })
  }
  render () {
    return (
      <form onSubmit={(e) => {
        e.preventDefault()
        this.props.setStatus('transacting')
        this.props.toggleScheduleform()
        console.log(
          vestingInstance.assignSchedule(
            this.state.address, this.state.name, this.state.start, this.state.end, this.state.cliff, this.state.value, {
              from: '0x8c719520fe06c03d413c63956d55480a18dde246'
            }
          ).then((transactObj) => {
            this.props.setStatus('idle')
            if (transactObj.logs.length) {
              this.props.updateTransactionDetails(transactObj)
            } else {
              window.alert(`Transaction could not be completed. Txhash: ${transactObj.tx}`)
            }
          }).catch((error) => {
            this.props.setStatus('idle')
            window.alert(error.message)
          })
        )
      }}>
        <div>
          <input
            placeholder='To address'
            onChange={(e) => {
              this.setValue('address', e.target.value)
            }}
          />
        </div>
        <div>
          <input
            placeholder='Name'
            onChange={(e) => {
              this.setValue('name', e.target.value)
            }} />
        </div>
        <div>
          <input
            placeholder='Start'
            onChange={(e) => {
              this.setValue('start', e.target.value)
            }} />
        </div>
        <div>
          <input
            placeholder='End'
            onChange={(e) => {
              this.setValue('end', e.target.value)
            }} />
        </div>
        <div>
          <input
            placeholder='Cliff'
            onChange={(e) => {
              this.setValue('cliff', e.target.value)
            }} />
        </div>
        <div>
          <input
            placeholder='Value'
            onChange={(e) => {
              this.setValue('value', e.target.value)
            }} />
        </div>
        <button type='Submit' onClick={() => {}}>Submit</button>
      </form>
    )
  }
}

const Button = (props) => (
  <button className='createScheduleButton' onClick={props.onClick} >
    {props.text}
  </button>
)

const TransactionDetail = (props) => (
  <div>
    <p style={{fontWeight: 'bold'}}>Last successful schedule</p>
    <p>{props.title} : {props.value}</p>
  </div>
)

ReactDOM.render(<Container />, document.getElementById('app'))

export default vestingImplementation
