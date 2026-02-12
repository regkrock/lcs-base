Class {
	#name : 'LxxPrototype2Module',
	#superclass : 'LcsModule',
	#category : 'Lcs-PrototypeSystem-Core',
	#package : 'Lcs-PrototypeSystem',
	#tag : 'Core'
}

{ #category : 'configuration' }
LxxPrototype2Module class >> defaultModuleName [
	^ 'Prototype 2 Module'
]

{ #category : 'configuration' }
LxxPrototype2Module class >> owningModules [
	<owningModule: 'LxxPrototypeSystem' priority: 50>
]
