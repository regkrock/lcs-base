Class {
	#name : #LcsMainSystemTest,
	#superclass : #LcsTestWithNoTestSystemSetupForTest,
	#category : #'Lcs-MainSystemTests'
}

{ #category : #tests }
LcsMainSystemTest >> testCreation [

	| currentUnitOfWork |

	self subject: LcsMainSystem new.
	self assert: self currentSystem notNil.
	self assert: self subject == self currentSystem.

	currentUnitOfWork := self currentSystem currentUnitOfWork.
	self assert: LcsApplicationEnvironment unitsOfWorkManager  hasUnitsOfWork. 
	self assert: currentUnitOfWork notNil.
	self assert: currentUnitOfWork system identicalTo: self currentSystem.
	self assert: self currentSystem notNil.
	self assert: (LcsPerson slotDefinitionNamed: #dateOfBirth) slotName equals: #dateOfBirth.
	self assert: (self currentSystem moduleNamed: LcsGeographyModule defaultModuleName) notNil
]
