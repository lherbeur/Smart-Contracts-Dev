
import { default as contract } from 'truffle-contract'
import consensusXArtifacts from '../build/contracts/ConsensusX.json'
import vestingArtifacts from '../build/contracts/Vesting.json'
import personaArtifacts from '../build/contracts/Persona.json'
import ownedArtifacts from '../build/contracts/Owned.json'

export const ConsensusX = contract(consensusXArtifacts)
export const Vesting = contract(vestingArtifacts)
export const Persona = contract(personaArtifacts)
export const Owned = contract(ownedArtifacts)
