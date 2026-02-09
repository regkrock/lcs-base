Class {
	#name : 'LcsInstanceInLocalCollectionSlot',
	#superclass : 'LcsAccessorSlot',
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'slot access' }
LcsInstanceInLocalCollectionSlot >> _currentSlotVarIn: aDomainObject [
	^ (self targetCollectionIn: aDomainObject)
		findItemIn: self targetSlotPath
		matching: self targetItem
		ifNone: [ self initialValueBlock cull: aDomainObject cull: self ]
]

{ #category : 'gt views' }
LcsInstanceInLocalCollectionSlot >> addAssociationsToUmlModel: aUmlModel [
	super addAssociationsToUmlModel: aUmlModel.
	aUmlModel
		"addAssociation: self collectionSlotName
			from: self domainClass
			to: self domainCollectionClass;"
		addAssociation: '0:m'
			from: self domainCollectionClass
			to: self domainCollectionElementClass;
		addAssociation: self selectionPath
			from: self domainClass
			to: self domainCollectionClass
]

{ #category : 'gt views' }
LcsInstanceInLocalCollectionSlot >> addClassesToUmlModel: umlModel [ 
	super addClassesToUmlModel: umlModel.
	umlModel addClass: self domainCollectionClass.
	self slotTypes notEmpty
		ifTrue: [ umlModel addClassNamed: self domainCollectionElementClass ]
]

{ #category : 'magritte' }
LcsInstanceInLocalCollectionSlot >> allowNilDescription [
	<magritteDescription>
	^ super allowNilDescription
		beReadOnly;
		yourself
]

{ #category : 'magritte' }
LcsInstanceInLocalCollectionSlot >> allowNullDescription [
	<magritteDescription>
	^ super allowNullDescription
		beReadOnly;
		yourself
]

{ #category : 'properties' }
LcsInstanceInLocalCollectionSlot >> collectionSlotName [
	^ self properties at: 'collectionSlotName'
]

{ #category : 'properties' }
LcsInstanceInLocalCollectionSlot >> collectionSlotName: aString [ 
	self properties at: 'collectionSlotName' put: aString
]

{ #category : 'magritte' }
LcsInstanceInLocalCollectionSlot >> collectionSlotNameDescription [
	<magritteDescription>
	^ MAStringDescription new
		label: 'Collection Slot Name';
		priority: 4;
		accessor: #collectionSlotName;
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize ];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ];
		addCondition: [ :aValue | aValue asString trim size >= 2 ] labelled: 'Enter a unique slot name of at least two characters in length';
		addCondition: [ :aValue | aValue asString trim asSymbol allSatisfy: [ :each | each isAlphaNumeric ] ] labelled: 'Slot Names can contain only alphanumerics';
		beRequired
]

{ #category : 'slot access' }
LcsInstanceInLocalCollectionSlot >> defaultInitialValueBlock [
	^ [ :parentDomainObject :slot | (slot targetCollectionIn: parentDomainObject) defaultInstance ]
]

{ #category : 'defaults' }
LcsInstanceInLocalCollectionSlot >> defaultPragmaSelector [
	^ self class collectionItemSlotDefinitionName
]

{ #category : 'querying' }
LcsInstanceInLocalCollectionSlot >> domainCollectionClass [
	^ (self domainClass
		perform: ((self propertyAt: 'collectionSlotName') , 'SlotDefinition') asSymbol)
		slotTypes first
]

{ #category : 'gt views' }
LcsInstanceInLocalCollectionSlot >> domainCollectionElementClass [
	^ self slotTypes first
]

{ #category : 'initialize' }
LcsInstanceInLocalCollectionSlot >> initialize [
	super initialize.
	self targetSlotPath: OrderedCollection new.
	self collectionSlotName: ''.
	self targetItem: ''
]

{ #category : 'gt views' }
LcsInstanceInLocalCollectionSlot >> selectionPath [
	| targetPathStream |
	targetPathStream := WriteStream on: String new.
	targetPathStream nextPutAll: self slotName; cr.
	(self propertyAt: 'targetSlotPath') do: [ :eachSlotName | targetPathStream nextPutAll: eachSlotName ] separatedBy: [ targetPathStream space ].
	targetPathStream nextPutAll: ' = '; nextPutAll: (self propertyAt: 'targetItem') printString.
	^ targetPathStream contents
]

{ #category : 'slot access' }
LcsInstanceInLocalCollectionSlot >> slotVarPut: anObject in: aTargetDomainObject [
	"self verifyCanAdd: anObject."
	(aTargetDomainObject slotDefinitionNamed: self collectionSlotName)
		add: anObject to: aTargetDomainObject.
	"(self targetCollectionIn: aTargetDomainObject) add: anObject."
]

{ #category : 'slot access' }
LcsInstanceInLocalCollectionSlot >> targetCollectionIn: aDomainObject [
	^ aDomainObject perform: self collectionSlotName asSymbol
]

{ #category : 'properties' }
LcsInstanceInLocalCollectionSlot >> targetItem [
	^ self properties at: 'targetItem' ifAbsentPut: [ '' ]
]

{ #category : 'properties' }
LcsInstanceInLocalCollectionSlot >> targetItem: aString [ 
	self properties at: 'targetItem' put: aString
]

{ #category : 'magritte' }
LcsInstanceInLocalCollectionSlot >> targetItemDescription [
	<magritteDescription>
	^ MAStringDescription new
		label: 'Target Item';
		priority: 6;
		accessor: #targetItem;
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize ];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ];
		addCondition: [ :aValue | aValue asString trim size >= 2 ] labelled: 'Enter the name of the target item';
		beRequired
]

{ #category : 'properties' }
LcsInstanceInLocalCollectionSlot >> targetSlotName [
	^ self propertyAt: 'targetSlotName' ifAbsent: [ ]
]

{ #category : 'properties' }
LcsInstanceInLocalCollectionSlot >> targetSlotName: anObject [
	self propertyAt: 'targetSlotName' put: anObject
]

{ #category : 'properties' }
LcsInstanceInLocalCollectionSlot >> targetSlotPath [
	^ self properties at: 'targetSlotPath'
]

{ #category : 'properties' }
LcsInstanceInLocalCollectionSlot >> targetSlotPath: aSlotNamesCollection [ 
	self properties at: 'targetSlotPath' put: aSlotNamesCollection asOrderedCollection
]

{ #category : 'magritte' }
LcsInstanceInLocalCollectionSlot >> targetSlotPathDescription [
	<magritteDescription>
	^ MAToManyRelationDescription new
		  label: 'Target Slot Path';
			accessor: (LcsMAPluggableAccessor 
						accessors: #(#targetSlotPath)
						read: [ :selectors | selectors ] 
						write: [ :aModel :setter :collection | 
							aModel perform: setter with: (collection collect: [ :each | each asSymbol ]) ]);
			classes: { String};
			priority: 35;
			beModifiable;
			labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ];
			blocListStencil: (
				self
					taggerStencilWithCompletion: GtClassesCompletionStrategy new
					andContextMenuBlock: nil);
			beRequired
]
