Class {
	#name : #LcsConvenienceModuleAccessMethodBuilder,
	#superclass : #LcsMethodBuilder,
	#instVars : [
		'owningModuleClass',
		'moduleName'
	],
	#category : #'Lcs-SlotTools'
}

{ #category : #categories }
LcsConvenienceModuleAccessMethodBuilder >> extendInPackage: aTargetPackageName [
	self categoryName: ('*' , aTargetPackageName) asSymbol
]

{ #category : #initialize }
LcsConvenienceModuleAccessMethodBuilder >> initialize [
	super initialize.
	self targetClassName: 'LcsModule'.
	self categoryName: #configuration
]

{ #category : #command }
LcsConvenienceModuleAccessMethodBuilder >> methodSource [
	^'<1s>
	^ self moduleNamed: ''<2s>''' expandMacrosWith: self selector with: self moduleName
]

{ #category : #accessing }
LcsConvenienceModuleAccessMethodBuilder >> moduleName [
	^ moduleName
]

{ #category : #accessing }
LcsConvenienceModuleAccessMethodBuilder >> moduleName: anObject [
	moduleName := anObject
]

{ #category : #accessing }
LcsConvenienceModuleAccessMethodBuilder >> owningModuleClass [
	^ owningModuleClass
]

{ #category : #accessing }
LcsConvenienceModuleAccessMethodBuilder >> owningModuleClass: anObject [
	owningModuleClass := anObject
]
