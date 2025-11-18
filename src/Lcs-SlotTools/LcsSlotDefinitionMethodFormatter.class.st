Class {
	#name : #LcsSlotDefinitionMethodFormatter,
	#superclass : #LcsObject,
	#instVars : [
		'slotTemplate',
		'selector',
		'slotClass',
		'properties',
		'slotCategory'
	],
	#category : #'Lcs-SlotTools'
}

{ #category : #'instance creation' }
LcsSlotDefinitionMethodFormatter class >> newOnSlotDefinition: aSlotDefinition [
	^ self new
		initializeOnSlotDefinition: aSlotDefinition;
		yourself
]

{ #category : #'instance creation' }
LcsSlotDefinitionMethodFormatter class >> newOnSlotDefinitionMethodBuilder: aSlotDefinitionMethodBuilder [
	^ self new
		initializeOnSlotDefinitionMethodBuilder: aSlotDefinitionMethodBuilder;
		yourself
]

{ #category : #format }
LcsSlotDefinitionMethodFormatter >> addClassTypeKeyword: aPropertyName argument: aClasses to: aStream [ 
	aClasses do: [ :eachClassName | 
		aStream addKeyword: aPropertyName argument: eachClassName asString ]
]

{ #category : #format }
LcsSlotDefinitionMethodFormatter >> addKeyword: aPropertyName argument: aValue to: aStream [
	(aPropertyName = 'slotName' and: [ aValue isNil ]) ifTrue: [ ^ self ].
	self slotTemplate notNil ifTrue: [
		(self slotTemplate isChangedProperty: aPropertyName value: aValue) ifFalse: [ ^ self ] ].

	aPropertyName = 'slotTypes' ifTrue: [ 
		^ self addClassTypeKeyword: 'addSlotType' argument: aValue to: aStream ].
		
	aPropertyName = 'collectionMemberTypes' ifTrue: [ 
		^ self addClassTypeKeyword: 'addCollectionMemberType' argument: aValue to: aStream ].

	aPropertyName = 'validationConditions' ifTrue: [ 
		^ self addValidationConditionsKeyword: aPropertyName argument: aValue to: aStream ].		

	aPropertyName = 'postUpdateActions' ifTrue: [ 
		^ self addPostUpdateActionsKeyword: aPropertyName argument: aValue to: aStream ].		
		
	aValue isString
		ifFalse: [ ^ aStream addKeyword: aPropertyName argument: aValue asString ].

	(self classFor: aValue) notNil
		ifTrue: [ ^ aStream addKeyword: aPropertyName argument: aValue ].

	aStream addKeyword: aPropertyName argument: aValue printString
]

{ #category : #format }
LcsSlotDefinitionMethodFormatter >> addPostUpdateActionsKeyword: aPropertyName argument: aPostUpdateActions to: aStream [ 
	aPostUpdateActions hasElements ifFalse: [ ^ self ].
	aPostUpdateActions do: [ :eachAction |
		aStream
			addKeyword: 'addPostUpdateAction'
			withRenderedAction: eachAction ]
]

{ #category : #format }
LcsSlotDefinitionMethodFormatter >> addProperties: aProperties to: aStream [
	aStream indent.
	aProperties keysAndValuesDo: [ :eachPropertyName :eachValue |
		self addKeyword: eachPropertyName argument: eachValue to: aStream ].
]

{ #category : #format }
LcsSlotDefinitionMethodFormatter >> addSlotTypesKeyword: aPropertyName argument: aSlotTypes to: aStream [ 
	aSlotTypes do: [ :eachClassName | 
		aStream addKeyword: aPropertyName argument: eachClassName asString ]
]

{ #category : #format }
LcsSlotDefinitionMethodFormatter >> addValidationConditionsKeyword: aPropertyName argument: aValidationConditions to: aStream [ 

	aValidationConditions hasElements ifFalse: [ ^ self ].

	aValidationConditions do: [ :each |
		aStream
			addKeyword: 'addValidationCondition'
			argument: each conditionBlock printString
			keyword: 'description'
			argument: each validationDescription printString  ]
]

{ #category : #format }
LcsSlotDefinitionMethodFormatter >> format: aSlotDefinition [
	| stream |
	stream := LcsMethodStream new.
	stream
		startSlotDefintionSource: self selector slotCategory: nil;
		addSlotDefinitionClassCreatonLine: self slotClass name.
	aSlotDefinition properties isEmpty ifTrue: [ ^ stream contents ].

	self addProperties: aSlotDefinition properties to: stream.

	stream addYourself.

	^ stream contents
]

{ #category : #initialize }
LcsSlotDefinitionMethodFormatter >> initializeOnSlotDefinition: aSlotDefinition [ 
	self slotTemplate: aSlotDefinition class new.
	self selector: aSlotDefinition slotDefinitionSelector.
	self slotClass: aSlotDefinition class.
	self properties: aSlotDefinition properties.
]

{ #category : #initialize }
LcsSlotDefinitionMethodFormatter >> initializeOnSlotDefinitionMethodBuilder: aSlotDefinitionMethodBuilder [ 
	self slotTemplate: aSlotDefinitionMethodBuilder slotTemplate.
	self selector: aSlotDefinitionMethodBuilder slotDefinitionSelector.
	self slotClass: (aSlotDefinitionMethodBuilder slotClass ifNil: [ '<missing slot class>' ]).
	self properties: aSlotDefinitionMethodBuilder properties.
	self slotCategory: aSlotDefinitionMethodBuilder slotCategory
]

{ #category : #format }
LcsSlotDefinitionMethodFormatter >> methodSource [
	| stream streamPostionBeforeAddingProperties |
	stream := LcsMethodStream new.
	stream
		startSlotDefintionSource: self selector slotCategory: self slotCategory;
		addSlotDefinitionClassCreatonLine: self slotClass name.
	self properties isEmpty ifTrue: [ ^ stream contents ].

	streamPostionBeforeAddingProperties := stream streamPosition.

	self addProperties: self properties to: stream.

	streamPostionBeforeAddingProperties = stream streamPosition
		ifFalse: [ stream addYourself ].

	^ stream contents
]

{ #category : #accessing }
LcsSlotDefinitionMethodFormatter >> properties [
	^ properties
]

{ #category : #accessing }
LcsSlotDefinitionMethodFormatter >> properties: anObject [
	properties := anObject
]

{ #category : #accessing }
LcsSlotDefinitionMethodFormatter >> selector [
	^ selector
]

{ #category : #accessing }
LcsSlotDefinitionMethodFormatter >> selector: anObject [
	selector := anObject
]

{ #category : #accessing }
LcsSlotDefinitionMethodFormatter >> slotCategory [
	^ slotCategory
]

{ #category : #accessing }
LcsSlotDefinitionMethodFormatter >> slotCategory: anObject [
	slotCategory := anObject
]

{ #category : #accessing }
LcsSlotDefinitionMethodFormatter >> slotClass [
	^ slotClass
]

{ #category : #accessing }
LcsSlotDefinitionMethodFormatter >> slotClass: anObject [
	slotClass := anObject
]

{ #category : #accessing }
LcsSlotDefinitionMethodFormatter >> slotTemplate [
	^ slotTemplate
]

{ #category : #accessing }
LcsSlotDefinitionMethodFormatter >> slotTemplate: anObject [
	slotTemplate := anObject
]
