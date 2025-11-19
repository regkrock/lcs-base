"
This defines a slot where the content of the slot is a member of a collection.

The slot is responsible for:
1) defining the location of the collection - module and slot name
2) the defualt instance used to initialize the slot to when it is created.

Note: Currently this is defined to look up a value in a global collection.
"
Class {
	#name : 'LcsMemberOfGlobalCollectionSlot',
	#superclass : 'LcsMemberOfCollectionSlot',
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'gt views' }
LcsMemberOfGlobalCollectionSlot >> addAssociationsToUmlModel: umlModel [ 
]

{ #category : 'gt views' }
LcsMemberOfGlobalCollectionSlot >> addClassesToUmlModel: aUmlModel [ 
	aUmlModel addClass: self class.
	aUmlModel addClass: self targetCollection class.
	"(aUmlModel classModelForClass: self targetClassName)
		addAssociation: self slotName toModelNamed: self collectionClassName."
]

{ #category : 'gt views' }
LcsMemberOfGlobalCollectionSlot >> addOtherSlotDefinitionDetailsTo: collection [
	super addOtherSlotDefinitionDetailsTo: collection.
	collection
		add: '' -> '';
		add: '------Source Collection Info------' -> ''.
	collection add: 'source collection' ->self collectionSlotName.
	collection add: 'source module' -> self collectionSlotModuleName
]

{ #category : 'slot model' }
LcsMemberOfGlobalCollectionSlot >> collectionModule [
	^ self currentSystem moduleNamed: self collectionSlotModuleName
]

{ #category : 'properties' }
LcsMemberOfGlobalCollectionSlot >> collectionSlotModuleName [
	^ self propertyAt: 'collectionSlotModuleName' ifAbsent: [ ]
]

{ #category : 'properties' }
LcsMemberOfGlobalCollectionSlot >> collectionSlotModuleName: aString [ 
	self propertyAt: 'collectionSlotModuleName' put: aString
]

{ #category : 'properties' }
LcsMemberOfGlobalCollectionSlot >> collectionSlotName [
	^ self propertyAt: 'collectionSlotName' ifAbsent: []
]

{ #category : 'properties' }
LcsMemberOfGlobalCollectionSlot >> collectionSlotName: aString [ 
	self propertyAt: 'collectionSlotName' put: aString
]

{ #category : 'gt views' }
LcsMemberOfGlobalCollectionSlot >> gtUMLFor: aView [
	<gtView>
	^ aView mondrian
		title: 'UML';
		priority: 20;
		tooltip: 'Existing Classes: gray, Proposed Classes: blue, Newly Created: brown';
		initialize: self umlModelMondrianView;
		send: [ :item | item modelClass ifNil: [ item ] ];
		actionUpdateButton
]

{ #category : 'slot model' }
LcsMemberOfGlobalCollectionSlot >> newInstance [
	^ self targetCollectionSlotDefinition collectionMemberTypes first new
]

{ #category : 'gt views' }
LcsMemberOfGlobalCollectionSlot >> proposedUmlModelFor: aUmlModel [
	^ LcsUml new proposedUmlModelFor: aUmlModel
]

{ #category : 'message' }
LcsMemberOfGlobalCollectionSlot >> sourceCollectionNotPopulatedMessage [
	^'Source collection in module: ''<1s>'', slot: ''<2s>'' not initialized' 
			expandMacrosWith: self collectionSlotModuleName 
			with: self collectionSlotName
]

{ #category : 'slot model' }
LcsMemberOfGlobalCollectionSlot >> targetCollection [
	^ self collectionModule perform: self collectionSlotName asSymbol
]

{ #category : 'slot model' }
LcsMemberOfGlobalCollectionSlot >> targetCollectionSlotDefinition [
	^ self collectionModule slotDefinitionNamed: self collectionSlotName asSymbol
]

{ #category : 'gt views' }
LcsMemberOfGlobalCollectionSlot >> umlModel [
	| umlModel |
	umlModel := LcsUmlModel new .
	self addClassesToUmlModel: umlModel.
	umlModel removeDuplicates.
	self addAssociationsToUmlModel: umlModel.
	umlModel resolveClassModelNames.
	^ umlModel
]

{ #category : 'gt views' }
LcsMemberOfGlobalCollectionSlot >> umlModelMondrianView [
	^ self proposedUmlModelFor: self umlModel
]
