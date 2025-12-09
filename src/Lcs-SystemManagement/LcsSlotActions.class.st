Class {
	#name : 'LcsSlotActions',
	#superclass : 'LcsApplicationObject',
	#traits : 'LtParentTrait + LtOrderedCollection',
	#classTraits : 'LtParentTrait classTrait + LtOrderedCollection classTrait',
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'comparing' }
LcsSlotActions >> = aValidationCollections [
	(aValidationCollections isKindOf: self class name) ifFalse: [ ^ false ].
	"self collection size = aValidationCollections collections size ifFalse: [ ^ false ]."
	^ self collection = aValidationCollections collection
]

{ #category : 'magritte' }
LcsSlotActions >> actionClass [
	self subclassResponsibility
]

{ #category : 'querying' }
LcsSlotActions >> actionWithDescription: aString [
	^ self detect: [ :each | each description = aString ] ifNone: [ ]
]

{ #category : 'magritte' }
LcsSlotActions >> actionsDescription [
	^ MAToManyRelationDescription new
		  accessor: #collection;
		  label: self actionsLabel;
		  default: #(  );
		  classes: { self actionClass };
		  priority: 25;
		  beModifiable;
		  blocItemStencil: [ :anItemViewModel :anItemIndex | 
			  anItemViewModel asElement
				  fitContent;
				  border:
					  (BlBorder
						   paint: BrGlamorousColors disabledButtonBorderColor
						   width: 1);
				  margin: (BlInsets
						   top: 0
						   right: 5
						   bottom: 5
						   left: 0);
				  padding: (BlInsets all: 5);
				  background: Color white ];
		  newItemStencil: [ self actionClass new
		  						parent: self;
		  						yourself ]
]

{ #category : 'magritte' }
LcsSlotActions >> actionsLabel [
	self subclassResponsibility
]

{ #category : 'conditions' }
LcsSlotActions >> addAction: anAction [
	anAction parent: self.
	^ self add: anAction
]

{ #category : 'gt views' }
LcsSlotActions >> gtItemsFor: aView [
	<gtView>
	self collection isNil ifTrue: [ ^ aView empty ].
	^ aView forward
		title: 'Items' translated;
		priority: 0.5;
		object: [ self collection ];
		view: #gtItemsFor:;
		actionUpdateButton
]

{ #category : 'comparing' }
LcsSlotActions >> hash [
	^ self collection inject: self identityHash into: [ :each :hash | hash bitXor: each hash ]
]

{ #category : 'initialize' }
LcsSlotActions >> initialize [ 
	super initialize.
	self collection: OrderedCollection new
]

{ #category : 'testing' }
LcsSlotActions >> isSameAs: anActions [
	(anActions isKindOf: self class) ifFalse: [ ^ false ].
	self collection size = anActions collection size ifFalse: [ ^ false ].
	self collection with: anActions collection do: [ :aAction :bAction |
		self assert: aAction description equals: bAction description. 
		self assert: aAction actionBlock asString equals: bAction actionBlock asString ] .
	^ true
]

{ #category : 'conditions' }
LcsSlotActions >> removeAction: anAction [
	^ self remove: anAction ifAbsent: []
]

{ #category : 'slot model' }
LcsSlotActions >> slotDefinition [
	^ self parent
]
