Class {
	#name : #LcsModules,
	#superclass : #LcsObject,
	#instVars : [
		'parent',
		'collection'
	],
	#category : #'Lcs-SystemManagement'
}

{ #category : #configuration }
LcsModules class >> collectionClass [
	^ LcsSmalltalkConfiguration stringDictionaryClass
]

{ #category : #accessing }
LcsModules >> applicationEnvironment [
	^ self parent applicationEnvironment
]

{ #category : #build }
LcsModules >> buildModuleFor: eachModuleClass [

	| module |
	module := eachModuleClass new.
	module parent: self.
	self collection at: module moduleName put: module.
	module buildModules
]

{ #category : #accessing }
LcsModules >> collection [
	^ collection
]

{ #category : #accessing }
LcsModules >> collection: anObject [
	collection := anObject
]

{ #category : #collection }
LcsModules >> contentsDo: aBlock [
	self collection do: [ :eachElement | aBlock value: eachElement ]
]

{ #category : #modules }
LcsModules >> findModuleNamed: aString [
	| foundModule |
	foundModule := self collection at: aString ifAbsent: [ nil ].
	foundModule ifNotNil: [ ^ foundModule ].
	self collection values do: [ :eachModule | 
		foundModule :=  eachModule modules findModuleNamed: aString.
		foundModule ifNotNil: [ ^ foundModule ] ].
	^nil
]

{ #category : #accessing }
LcsModules >> gtApplicationModulesFor: aView [
	<gtView>
	self hasNoElements ifTrue: [ ^ aView empty ].
	^ aView columnedTree
		title: 'Modules';
		priority: 10;
		items: [ self moduleViewChildren ];
		children: [ :each | (each isAssociation ifTrue: [ each value ] ifFalse: [ each ]) moduleViewChildren ];
		column: 'Module Name'
			text: #key
			width: 200;
		column: 'Value'
			text: #value
			width: 120;
		send: #value;
		yourself
]

{ #category : #testing }
LcsModules >> hasElements [
	^ self collection notEmpty
]

{ #category : #testing }
LcsModules >> hasNoElements [
	^ self collection isEmpty
]

{ #category : #initialize }
LcsModules >> initialize [ 
	super initialize.
	self collection: Dictionary new
]

{ #category : #accessing }
LcsModules >> initializeModel [
	self collection valuesDo: [ :eachModule | eachModule initializeModel ]
]

{ #category : #testing }
LcsModules >> isEmpty [
	^self collection isEmpty
]

{ #category : #testing }
LcsModules >> isNotEmpty [
	^ self isEmpty not
]

{ #category : #modules }
LcsModules >> moduleNamed: aString ifAbsent: aBlock [
	^ self collection at: aString ifAbsent: aBlock
]

{ #category : #accessing }
LcsModules >> moduleViewChildren [
	self collection isEmpty ifTrue: [ ^ #() ].
	^ self collection associations
]

{ #category : #modules }
LcsModules >> numberOfModules [
	^ self collection size
]

{ #category : #accessing }
LcsModules >> parent [
	^ parent
]

{ #category : #accessing }
LcsModules >> parent: anObject [
	parent := anObject
]
