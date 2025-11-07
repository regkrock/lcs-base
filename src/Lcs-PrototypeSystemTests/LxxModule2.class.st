Class {
	#name : #LxxModule2,
	#superclass : #LcsModule,
	#category : #'Lcs-PrototypeSystemTests-Support'
}

{ #category : #configuration }
LxxModule2 class >> defaultModuleName [
	^ '2 Module'
]

{ #category : #configuration }
LxxModule2 class >> owningModules [
	<owningModule: 'LxxModule1' priority: 50>
]
