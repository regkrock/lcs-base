Class {
	#name : #LxxPrototypeSystemTest,
	#superclass : #LcsDomainTest,
	#category : #'Lcs-PrototypeSystemTests'
}

{ #category : #tests }
LxxPrototypeSystemTest >> testCreation [
	| system |
	system := LxxPrototypeSystem new.
	self assert: self currentSystem identicalTo: system.
	self assert: (system moduleNamed: LxxPersonsModule moduleName) class name equals: #LxxPersonsModule.
	self assert: (system moduleNamed: LxxPrototype2Module moduleName) class name equals: #LxxPrototype2Module.
	self assert: system numberOfChildModules equals: 2. 
	self assert: (system moduleNamed: LxxPersonsModule moduleName) numberOfChildModules equals: 0.
	self assert: (system moduleNamed: LxxPrototype2Module moduleName) numberOfChildModules equals: 1.
	self assert: (system moduleNamed: LxxPrototype2Submodule moduleName) numberOfChildModules equals: 0.
	self assert:system hasValidConfiguration. 
]
