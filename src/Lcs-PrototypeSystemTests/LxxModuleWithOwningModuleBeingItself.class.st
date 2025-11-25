"
Do not use - this is for a specific test
"
Class {
	#name : 'LxxModuleWithOwningModuleBeingItself',
	#superclass : 'LcsModule',
	#category : 'Lcs-PrototypeSystemTests-Support',
	#package : 'Lcs-PrototypeSystemTests',
	#tag : 'Support'
}

{ #category : 'configuration' }
LxxModuleWithOwningModuleBeingItself class >> defaultModuleName [
	^ 'Module With Owning Module Being Itself'
]

{ #category : 'configuration' }
LxxModuleWithOwningModuleBeingItself class >> owningModules [
	<owningModule: 'LxxModuleWithOwningModuleBeingItself' priority: 50>
]
