Class {
	#name : #LcsSystemTest,
	#superclass : #TestCase,
	#category : #'Lcs-SystemTests'
}

{ #category : #accessing }
LcsSystemTest >> testCreation [

	| currentUnitOfWork system |

	LcsSystem clearSingleton.
	self assert: LcsSystem basicSingleton isNil. 
	system := LcsSystem singleton.
	self assert: system notNil.

	currentUnitOfWork := system currentUnitOfWork.
	self assert: system unitsOfWork notEmpty. 
	self assert: currentUnitOfWork notNil.
	self assert: currentUnitOfWork system identicalTo: system.
	self assert: LcsSystem basicSingleton notNil.
	self assert: (LcsPerson slotDefinitionNamed: #dateOfBirth) slotName equals: #dateOfBirth
]
