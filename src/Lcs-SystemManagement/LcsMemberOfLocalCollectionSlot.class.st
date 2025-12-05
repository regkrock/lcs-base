Class {
	#name : 'LcsMemberOfLocalCollectionSlot',
	#superclass : 'LcsMemberOfCollectionSlot',
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'properties' }
LcsMemberOfLocalCollectionSlot >> collectionSlotName [
	^ self propertyAt: 'collectionSlotName' ifAbsent: []
]

{ #category : 'properties' }
LcsMemberOfLocalCollectionSlot >> collectionSlotName: aString [ 
	self propertyAt: 'collectionSlotName' put: aString
]

{ #category : 'properties' }
LcsMemberOfLocalCollectionSlot >> collectionSlotNameDescription [
	<magritteDescription>
	^ MAStringDescription new
		label: 'Collection slot name';
		priority: 11;
		default: '';
		accessor: #collectionSlotName;
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ];
		yourself
]

{ #category : 'defaults' }
LcsMemberOfLocalCollectionSlot >> defaultInitialValueBlock [
	^ [ :parentDomainObject :slot | (slot targetCollectionIn: parentDomainObject) defaultInstance ]
]

{ #category : 'gt views' }
LcsMemberOfLocalCollectionSlot >> gtUMLFor: aView [
	<gtView>
	^ aView mondrian
		title: 'UML';
		priority: 20;
		initialize: self umlModelMondrianView;
		send: [ :item | item modelClass ifNil: [ item ] ];
		actionUpdateButton
]

{ #category : 'initialize' }
LcsMemberOfLocalCollectionSlot >> initialize [
	super initialize.
	self targetSlotPath: OrderedCollection new
]

{ #category : 'properties' }
LcsMemberOfLocalCollectionSlot >> targetSlotPath [
	^ self propertyAt: 'targetSlotPath' ifAbsent: []
]

{ #category : 'properties' }
LcsMemberOfLocalCollectionSlot >> targetSlotPath: aString [ 
	self propertyAt: 'targetSlotPath' put: aString
]

{ #category : 'gt views' }
LcsMemberOfLocalCollectionSlot >> targetSlotPathDescription [
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

{ #category : 'gt views' }
LcsMemberOfLocalCollectionSlot >> umlModel [
	| umlModel |
	umlModel := LcsUmlModel new.
	self addClassesToUmlModel: umlModel.
	umlModel removeDuplicates.
	self addAssociationsToUmlModel: umlModel.
	umlModel resolveClassModelNames.
	^ umlModel
]

{ #category : 'gt views' }
LcsMemberOfLocalCollectionSlot >> umlModelMondrianView [
	^ LcsUml new proposedUmlModelFor: self umlModel
]
