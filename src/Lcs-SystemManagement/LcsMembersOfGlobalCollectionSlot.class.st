Class {
	#name : 'LcsMembersOfGlobalCollectionSlot',
	#superclass : 'LcsMembersOfCollectionSlot',
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'gt views' }
LcsMembersOfGlobalCollectionSlot >> addAssociationsToUmlModel: umlModel [ 
	super addAssociationsToUmlModel: umlModel 
]

{ #category : 'gt views' }
LcsMembersOfGlobalCollectionSlot >> addClassesToUmlModel: aUmlModel [ 
	super addClassesToUmlModel: aUmlModel .
	aUmlModel addClass: self class.
	aUmlModel addClass: self targetCollection class.
	"(aUmlModel classModelForClass: self targetClassName)
		addAssociation: self slotName toModelNamed: self collectionClassName."
]

{ #category : 'slot model' }
LcsMembersOfGlobalCollectionSlot >> collectionModule [
	^ (self currentSystem ifNil: [ LcsNoSystemError signal ])
		moduleNamed: self collectionSlotModuleName
]

{ #category : 'properties' }
LcsMembersOfGlobalCollectionSlot >> collectionSlotModuleName [
	^ self propertyAt: #'collectionSlotModuleName' ifAbsent: [ ]
]

{ #category : 'properties' }
LcsMembersOfGlobalCollectionSlot >> collectionSlotModuleName: aString [ 
	self propertyAt: #'collectionSlotModuleName' put: aString
]

{ #category : 'properties' }
LcsMembersOfGlobalCollectionSlot >> collectionSlotName [
	^ self propertyAt: #'collectionSlotName' ifAbsent: []
]

{ #category : 'properties' }
LcsMembersOfGlobalCollectionSlot >> collectionSlotName: aString [ 
	self propertyAt: #'collectionSlotName' put: aString
]

{ #category : 'slot model' }
LcsMembersOfGlobalCollectionSlot >> defaultInstance [
	^ self targetCollection 
		ifNil: [ LcsMemberOfSlotSourceCollectionNotInitialized signalWithContext: self ] 
		ifNotNil: [ :collection | collection defaultInstance ]
]

{ #category : 'gt views' }
LcsMembersOfGlobalCollectionSlot >> gtUMLFor: aView [
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
LcsMembersOfGlobalCollectionSlot >> newInstance [
	^ self targetCollectionSlotDefinition collectionMemberTypes first new
]

{ #category : 'gt views' }
LcsMembersOfGlobalCollectionSlot >> proposedUmlModelFor: aUmlModel [
	^ LcsUml new proposedUmlModelFor: aUmlModel
]

{ #category : 'message' }
LcsMembersOfGlobalCollectionSlot >> sourceCollectionNotPopulatedMessage [
	^'Source collection in module: ''<1s>'', slot: ''<2s>'' not initialized' 
			expandMacrosWith: self collectionSlotModuleName 
			with: self collectionSlotName
]

{ #category : 'slot model' }
LcsMembersOfGlobalCollectionSlot >> targetCollection [
	^ self collectionModule perform: self collectionSlotName asSymbol
]

{ #category : 'slot model' }
LcsMembersOfGlobalCollectionSlot >> targetCollectionSlotDefinition [
	^ self collectionModule slotDefinitionNamed: self collectionSlotName asSymbol
]

{ #category : 'gt views' }
LcsMembersOfGlobalCollectionSlot >> umlModelMondrianView [
	^ self proposedUmlModelFor: self umlModel
]
