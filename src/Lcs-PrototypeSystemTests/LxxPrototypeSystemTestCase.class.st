Class {
	#name : #LxxPrototypeSystemTestCase,
	#superclass : #LcsTestCase,
	#category : #'Lcs-PrototypeSystemTests'
}

{ #category : #tests }
LxxPrototypeSystemTestCase >> testCreation [
	| system |
	system := LxxPrototypeSystem newSystem.
	self assert: self currentSystem == system.
	self assert: (system moduleNamed: LxxPrototype1Module moduleName) class name equals: #LxxPrototype1Module.
	self assert: (system moduleNamed: LxxPrototype2Module moduleName) class name equals: #LxxPrototype2Module.
	self assert: system numberOfChildModules equals: 2. 
	self assert: (system moduleNamed: LxxPrototype1Module moduleName) numberOfChildModules equals: 0.
	self assert: (system moduleNamed: LxxPrototype2Module moduleName) numberOfChildModules equals: 0.
	system validateConfiguration. 
]
