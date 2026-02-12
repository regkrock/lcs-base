Class {
	#name : 'LcsInstanceInLocalCollectionSlotBuilder',
	#superclass : 'LcsFacadeSlotBuilder',
	#category : 'Lcs-SlotTools-Core',
	#package : 'Lcs-SlotTools',
	#tag : 'Core'
}

{ #category : 'configuration' }
LcsInstanceInLocalCollectionSlotBuilder class >> slotClass [
	^ LcsInstanceInLocalCollectionSlot
]

{ #category : 'magritte' }
LcsInstanceInLocalCollectionSlotBuilder >> allowNilDescription [
	<magritteDescription>
	^ super allowNilDescription
		beReadOnly;
		yourself
]

{ #category : 'magritte' }
LcsInstanceInLocalCollectionSlotBuilder >> allowNullDescription [
	<magritteDescription>
	^ super allowNullDescription
		beReadOnly;
		yourself
]

{ #category : 'job steps' }
LcsInstanceInLocalCollectionSlotBuilder >> buildJobSteps [
	self addJobStep: self slotDefinitionMethodBuilder.
	self addJobStep: self getterAndSetterMethodsBuilder
]

{ #category : 'properties' }
LcsInstanceInLocalCollectionSlotBuilder >> collectionSlotName [
	^ self properties at: 'collectionSlotName' ifAbsentPut: [ '' ]
]

{ #category : 'properties' }
LcsInstanceInLocalCollectionSlotBuilder >> collectionSlotName: aString [ 
	self properties at: 'collectionSlotName' put: aString
]

{ #category : 'magritte' }
LcsInstanceInLocalCollectionSlotBuilder >> collectionSlotNameDescription [
	<magritteDescription>
	^ MAStringDescription new
		label: 'Collection Slot Name';
		priority: 5;
		accessor: #collectionSlotName;
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize ];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ];
		addCondition: [ :aValue | aValue asString trim size >= 2 ] labelled: 'Enter a unique slot name of at least two characters in length';
		addCondition: [ :aValue | aValue asString trim asSymbol allSatisfy: [ :each | each isAlphaNumeric ] ] labelled: 'Slot Names can contain only alphanumerics';
		beRequired
]

{ #category : 'defaults' }
LcsInstanceInLocalCollectionSlotBuilder >> defaultInitialValueBlock [
	^ [ :parentDomainObject :slot | (parentDomainObject perform: self collectionSlotName) findItemIn: slot targetSlotPath matching: slot targetItem ]
]

{ #category : 'job steps' }
LcsInstanceInLocalCollectionSlotBuilder >> slotDefinitionMethodBuilder [
	^ super slotDefinitionMethodBuilder
			beCollectionItemSlot;
			yourself
]

{ #category : 'properties' }
LcsInstanceInLocalCollectionSlotBuilder >> targetItem [
	^ self properties at: 'targetItem' ifAbsentPut: [ '' ]
]

{ #category : 'properties' }
LcsInstanceInLocalCollectionSlotBuilder >> targetItem: aString [ 
	self properties at: 'targetItem' put: aString
]

{ #category : 'magritte' }
LcsInstanceInLocalCollectionSlotBuilder >> targetItemDescription [
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
LcsInstanceInLocalCollectionSlotBuilder >> targetSlotPath [
	^ self properties at: 'targetSlotPath'
]

{ #category : 'properties' }
LcsInstanceInLocalCollectionSlotBuilder >> targetSlotPath: aSlotNamesCollection [ 
	self properties at: 'targetSlotPath' put: aSlotNamesCollection asOrderedCollection
]

{ #category : 'magritte' }
LcsInstanceInLocalCollectionSlotBuilder >> targetSlotPathDescription [
	<magritteDescription>
	^ MAToManyRelationDescription new
		  label: 'Target Slot Path';
			accessor: (LcsMAPluggableAccessor 
						accessors: #(#targetSlotPath)
						read: [ :selectors | selectors ] 
						write: [ :aModel :setter :collection | 
							aModel perform: setter with: (collection collect: [ :each | each asSymbol ]) ]);
			classes: { String};
			priority: 7;
			beModifiable;
			labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ];
			blocListStencil: (
				self
					taggerStencilWithCompletion: GtClassesCompletionStrategy new
					andContextMenuBlock: nil);
			beRequired
]
