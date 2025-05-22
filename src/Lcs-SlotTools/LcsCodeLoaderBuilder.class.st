Class {
	#name : #LcsCodeLoaderBuilder,
	#superclass : #LcsCodeBuilderStep,
	#category : #'Lcs-SlotTools'
}

{ #category : #'as yet unclassified' }
LcsCodeLoaderBuilder >> installCode [
	super installCode.
	self addRefactoring: (RBAddClassChange definition: self classCreationString) execute.
	self installedClass: self refactorings last changeClass.
	self beCodeInstalled
]
