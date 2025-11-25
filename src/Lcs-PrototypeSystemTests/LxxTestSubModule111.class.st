Class {
	#name : 'LxxTestSubModule111',
	#superclass : 'LxxTestSubModule11',
	#category : 'Lcs-PrototypeSystemTests-Support',
	#package : 'Lcs-PrototypeSystemTests',
	#tag : 'Support'
}

{ #category : 'configuration' }
LxxTestSubModule111 class >> defaultModuleName [
	^ 'Prototype 111 Submodule'
]

{ #category : 'configuration' }
LxxTestSubModule111 class >> owningModules [
	<owningModule: 'LxxTestSubModule11' priority: 50>
]
