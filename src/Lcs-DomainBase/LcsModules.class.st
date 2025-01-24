Class {
	#name : #LcsModules,
	#superclass : #LcsDomainCollection,
	#category : #'Lcs-DomainBase-Core'
}

{ #category : #'slot definition' }
LcsModules class >> collectionSlotDefinition [
	<slotDefinition>
	^ LcsDirectAssignmentSlot new
		slotName: 'collection';
		addSlotType: LcsSmalltalkConfiguration stringDictionaryClass;
		yourself
]

{ #category : #'application environment' }
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
	"Bypass unit of work - this is a setup situation"
	^ collection
]

{ #category : #accessing }
LcsModules >> collection: aCollection [
	"Bypass unit of work - this is a setup situation"
	collection := aCollection
]

{ #category : #modules }
LcsModules >> findModuleNamed: aString [
	| foundModule |
	foundModule := self collection at: aString ifAbsent: [ nil ].
	foundModule ifNotNil: [ ^ foundModule ].
	self collection valuesDo: [ :eachModule | 
		foundModule :=  eachModule modules findModuleNamed: aString.
		foundModule ifNotNil: [ ^ foundModule ] ].
	^ nil
]

{ #category : #'gt view' }
LcsModules >> gtApplicationModulesFor: aView [
	<gtView>
	self hasNoElements ifTrue: [ ^ aView empty ].
	^ aView columnedTree
		title: 'Modules';
		priority: 10;
		items: [ self moduleViewChildren ];
		children: [ :each | each children ];
		column: 'Module Name'
			text: [ :each | each label ]
			width: 200;
		column: 'Value'
			text: [ :each | each item ];
		send: #item;
		yourself
]

{ #category : #build }
LcsModules >> initializeModel [
	super initializeSlotValues.
	self collection valuesDo: [ :eachModule | eachModule initializeModel ]
]

{ #category : #modules }
LcsModules >> moduleNamed: aString ifAbsent: aBlock [
	^ self collection at: aString ifAbsent: aBlock
]

{ #category : #'gt view' }
LcsModules >> moduleViewChildren [
	^ self collect: [ :each | LcsModuleViewItem newLabel: each moduleName item: each ]
]

{ #category : #modules }
LcsModules >> numberOfModules [
	^ self collection size
]
