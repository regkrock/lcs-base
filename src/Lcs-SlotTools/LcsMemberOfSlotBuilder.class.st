Class {
	#name : #LcsMemberOfSlotBuilder,
	#superclass : #LcsSlotDefinitionBuilder,
	#instVars : [
		'collectionSlotName',
		'slotTypes',
		'collectionSlotModuleName'
	],
	#category : #'Lcs-SlotTools'
}

{ #category : #defaults }
LcsMemberOfSlotBuilder class >> slotDefinitionClass [
	^ LcsMemberOfSlot
]

{ #category : #'gt views' }
LcsMemberOfSlotBuilder >> addModelAssociationsTo: aCollection [
	aCollection add: self targetClass-> {{self slotName. self domainClass}}
]

{ #category : #'gt views' }
LcsMemberOfSlotBuilder >> addSlotDefinitionSourceDetailsTo: codeStream [
	self slotTypes isEmpty
		ifTrue: [
			codeStream addSetter: 'addSlotType' contents: '<no slot types defined>' printString ]
		ifFalse: [ 
			self slotTypesNames do: [ :eachName | 
				codeStream addSetter: 'addSlotType' contents: eachName ] ].
	codeStream
		addSetter: 'collectionSlotName' contents: (self collectionSlotName ifNil: [ '<missing>' ]) printString;
		addSetter: 'collectionSlotModuleName' contents: (self collectionSlotModuleName ifNil: [ '<missing>' ]) printString
]

{ #category : #initialize }
LcsMemberOfSlotBuilder >> addSlotType: aClass [
	self slotTypes add: aClass
]

{ #category : #accessing }
LcsMemberOfSlotBuilder >> collectionSlotModuleName [
	^ collectionSlotModuleName
]

{ #category : #accessing }
LcsMemberOfSlotBuilder >> collectionSlotModuleName: aString [
	collectionSlotModuleName := aString
]

{ #category : #accessing }
LcsMemberOfSlotBuilder >> collectionSlotName [
	^ collectionSlotName
]

{ #category : #accessing }
LcsMemberOfSlotBuilder >> collectionSlotName: anObject [
	collectionSlotName := anObject
]

{ #category : #'gt views' }
LcsMemberOfSlotBuilder >> domainClass [
	^ self newDomainClassName asClass
]

{ #category : #initialize }
LcsMemberOfSlotBuilder >> initialize [
	super initialize.
	self slotTypes: OrderedCollection new
]

{ #category : #'gt views' }
LcsMemberOfSlotBuilder >> newDomainClassName [
	^ self parent parent newDomainClassName
]

{ #category : #accessing }
LcsMemberOfSlotBuilder >> slotTypes [
	^ slotTypes
]

{ #category : #accessing }
LcsMemberOfSlotBuilder >> slotTypes: anObject [
	slotTypes := anObject
]

{ #category : #asking }
LcsMemberOfSlotBuilder >> slotTypesNames [
	^ self slotTypes collect: [ :each |
		each isClass 
			ifTrue: [ each name ]
			ifFalse: [ each] ]
]

{ #category : #accessing }
LcsMemberOfSlotBuilder >> targetModuleName [
	^ self targetModuleClass defaultModuleName
]

{ #category : #command }
LcsMemberOfSlotBuilder >> uninstall [
	self target removeDomainSlotNamed: self slotName.
]
