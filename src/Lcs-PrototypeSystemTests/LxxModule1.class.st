"
Do not use - this is for a specific test
"
Class {
	#name : 'LxxModule1',
	#superclass : 'LcsModule',
	#category : 'Lcs-PrototypeSystemTests-Support',
	#package : 'Lcs-PrototypeSystemTests',
	#tag : 'Support'
}

{ #category : 'configuration' }
LxxModule1 class >> defaultModuleName [
	^ '1 Module'
]

{ #category : 'configuration' }
LxxModule1 class >> owningModules [
	<owningModule: 'LxxModule0' priority: 50>
	<owningModule: 'LxxModule2' priority: 50>
]
