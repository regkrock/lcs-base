"
Do not use - this is for a specific test
"
Class {
	#name : #LxxModuleWithOwningModuleBeingItself,
	#superclass : #LcsModule,
	#category : #'Lcs-PrototypeSystemTests-Support'
}

{ #category : #configuration }
LxxModuleWithOwningModuleBeingItself class >> defaultModuleName [
	^ self class name
]

{ #category : #configuration }
LxxModuleWithOwningModuleBeingItself class >> owningModules [
	<owningModule: 'LxxModuleWithOwningModuleBeingItself' priority: 50>
]
