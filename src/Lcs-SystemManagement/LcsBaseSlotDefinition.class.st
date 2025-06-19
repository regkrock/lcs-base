Class {
	#name : #LcsBaseSlotDefinition,
	#superclass : #LcsApplicationObject,
	#instVars : [
		'slotName',
		'parent',
		'slotTypes',
		'domainClass',
		'validationConditions',
		'priority'
	],
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #configuration }
LcsBaseSlotDefinition >> addSlotType: aClass [
	(self slotTypes includes: aClass) ifFalse: [ self slotTypes add: aClass ]
]

{ #category : #validations }
LcsBaseSlotDefinition >> addValidationCondition: aValidationCondition [
	self validationConditions addValidationCondition: aValidationCondition
]

{ #category : #validations }
LcsBaseSlotDefinition >> addValidationCondition: aBlock description: aString [
	self validationConditions addValidationCondition: aBlock description: aString
]

{ #category : #configuration }
LcsBaseSlotDefinition >> clearSlotTypes [
	self slotTypes removeAll.
]

{ #category : #'slot model' }
LcsBaseSlotDefinition >> domainClass [
	^ domainClass ifNil: [ domainClass := self parent domainClass ]
]

{ #category : #'slot model' }
LcsBaseSlotDefinition >> domainClass: aDomainClass [
	domainClass := aDomainClass
]

{ #category : #magritte }
LcsBaseSlotDefinition >> domainClassDescription [
	<magritteDescription>
	^ MAStringDescription new
		label: 'Domain Class';
		priority: 12;
		accessor: #'domainClass';
		beReadOnly;
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize ];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ]

]

{ #category : #initialize }
LcsBaseSlotDefinition >> initialize [
	super initialize.
	self initializeSlotTypes.
	self validationConditions: (LcsValidationConditions newOn: self).
	self priority: 50
]

{ #category : #initialize }
LcsBaseSlotDefinition >> initializeSlotTypes [
	self slotTypes: OrderedCollection new
]

{ #category : #'slot model' }
LcsBaseSlotDefinition >> label [
	^self labelForSelector: self slotName
]

{ #category : #accessing }
LcsBaseSlotDefinition >> parent [
	^ parent
]

{ #category : #accessing }
LcsBaseSlotDefinition >> parent: anObject [
	parent := anObject
]

{ #category : #accessing }
LcsBaseSlotDefinition >> priority [
	^ priority
]

{ #category : #accessing }
LcsBaseSlotDefinition >> priority: anObject [
	priority := anObject
]

{ #category : #magritte }
LcsBaseSlotDefinition >> priorityDescription [
	<magritteDescription>
	^ MANumberDescription new
		label: 'Priority';
		priority: 10;
		accessor: #'priority';
		kind: Object;
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize ];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ];
		beRequired

]

{ #category : #validations }
LcsBaseSlotDefinition >> removeValidationCondition: aValidationCondition [
	self validationConditions removeValidationCondition: aValidationCondition
]

{ #category : #validations }
LcsBaseSlotDefinition >> removeValidationConditionWithDescription: aString [
	self validationConditions removeValidationConditionWithDescription: aString
]

{ #category : #magritte }
LcsBaseSlotDefinition >> requiredDescription [
	<magritteDescription>
	^ MABooleanDescription new
		label: 'Required';
		priority: 10;
		accessor: #'required';
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize ];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ];
"		addCondition: [ :aValue | aValue asString trim size >= 2 ] labelled: 'Enter a unique slot name of at least two characters in length';
		addCondition: [ :aValue | (existingInstvarNames includes: aValue asString trim asSymbol) not ] labelled: 'Slot already exists';"
		"addCondition: [ :aValue | aValue trim isEmpty  ] labelled: 'Enter a unique slot name of at least two characters in length';"
		"addCondition: [ :aValue | aValue trim isEmpty  ] labelled: 'Enter a unique slot name of at least two characters in length';"
		beRequired

]

{ #category : #defaults }
LcsBaseSlotDefinition >> slotClass [
	^ self slotTypes any
]

{ #category : #magritte }
LcsBaseSlotDefinition >> slotDefinitionClassDescription [
	<magritteDescription>
	^ MAStringDescription new
		label: 'Slot Definition Class';
		priority: 1;
		accessor: #'className';
		kind: Object;
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize ];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ];
		beReadOnly

]

{ #category : #accessing }
LcsBaseSlotDefinition >> slotName [
	^ slotName
]

{ #category : #accessing }
LcsBaseSlotDefinition >> slotName: anObject [
	slotName := anObject
]

{ #category : #magritte }
LcsBaseSlotDefinition >> slotNameDescription [
	<magritteDescription>
	| existingInstvarNames |
	existingInstvarNames := self domainClass ifNil: [ #() ] ifNotNil: [ :c | c allInstVarNames ].
	^ GtMATextDescription new
		label: 'Slot Name';
		priority: 1;
		accessor: #'slotName';
		kind: Object;
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize
				"+ (BrGlamorousWithExplicitContextMenuAptitude
						itemsWithAnchorActions: [ self contextMenuItemsForSuperclass ])" ];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ];
		addCondition: [ :aValue | aValue asString trim size >= 2 ] labelled: 'Enter a unique slot name of at least two characters in length';
		addCondition: [ :aValue | (existingInstvarNames includes: aValue asString trim asSymbol) not ] labelled: 'Slot already exists';
		"addCondition: [ :aValue | aValue trim isEmpty  ] labelled: 'Enter a unique slot name of at least two characters in length';"
		"addCondition: [ :aValue | aValue trim isEmpty  ] labelled: 'Enter a unique slot name of at least two characters in length';"
		beRequired

]

{ #category : #'gt views' }
LcsBaseSlotDefinition >> slotTypeClassNames [
	| stream |
	stream := WriteStream on: String new.
	self slotTypes do: [ :eachClass |
		stream nextPutAll: (
			eachClass isClass 
				ifTrue: [ eachClass name displayString ] 
				ifFalse: [ eachClass printString ])  ] separatedBy: [ stream nextPutAll: ', '].
	^stream contents
]

{ #category : #accessing }
LcsBaseSlotDefinition >> slotTypes [
	^ slotTypes
]

{ #category : #accessing }
LcsBaseSlotDefinition >> slotTypes: anObject [
	slotTypes := anObject
]

{ #category : #magritte }
LcsBaseSlotDefinition >> slotTypesDescription [
	<magritteDescription>
	^ MAToManyRelationDescription new
		label: 'Slot Types';
		priority: 25;
		accessor: #slotTypes;
		classes: {String};
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ];
		blocShortcuts: [ {BlShortcutWithAction new
					name: 'Browse class';
					description: 'Browses the class indicated by the editor';
					combination: BlKeyCombination primaryB;
					action: [ :anEvent | 
						anEvent target phlow
							spawnTool: (GtClassCoderTool forClass: anEvent target text asString asClass) ].
				BlShortcutWithAction new
					name: 'Inspect class';
					description: 'Inspects the class indicated by the editor';
					combination: BlKeyCombination primaryG;
					action: [ :anEvent | anEvent target phlow spawnObject: anEvent target text asString asClass ].
				BlShortcutWithAction new
					name: 'Browse class references';
					description: 'Browses references to the class indicated by the editor';
					combination: BlKeyCombination primaryN;
					action: [ :anEvent | 
						anEvent target phlow
							spawnObject: anEvent target text asString asClass gtReferences ]} ];
		beReadOnly

]

{ #category : #'slot model' }
LcsBaseSlotDefinition >> slotVarPut: anObject in: aDomainObject [
	^ LcsError signal: 'Attempt to update a read only slot'
]

{ #category : #validations }
LcsBaseSlotDefinition >> validate: aValue [
	(LcsConditionsValidator newOn: self)
		validate: aValue
]

{ #category : #validations }
LcsBaseSlotDefinition >> validate: aValue context: aDomainObject [
	(LcsConditionsValidator newOn: self)
		validate: aValue context: aDomainObject
]

{ #category : #accessing }
LcsBaseSlotDefinition >> validationConditions [
	^ validationConditions
]

{ #category : #accessing }
LcsBaseSlotDefinition >> validationConditions: anObject [
	validationConditions := anObject
]
