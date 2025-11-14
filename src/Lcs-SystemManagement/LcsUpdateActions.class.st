Class {
	#name : #LcsUpdateActions,
	#superclass : #LcsApplicationObject,
	#traits : 'LtParentTrait + LtOrderedCollection',
	#classTraits : 'LtParentTrait classTrait + LtOrderedCollection classTrait',
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #comparing }
LcsUpdateActions >> = aValidationCollections [
	(aValidationCollections isKindOf: self class name) ifFalse: [ ^ false ].
	"self collection size = aValidationCollections collections size ifFalse: [ ^ false ]."
	^ self collection = aValidationCollections collection
]

{ #category : #conditions }
LcsUpdateActions >> addPostUpdateAction: anUpdateAction [
	anUpdateAction parent: self.
	^ self add: anUpdateAction
]

{ #category : #conditions }
LcsUpdateActions >> addUpdateAction: anUpdateAction [
	anUpdateAction parent: self.
	^ self add: anUpdateAction
]

{ #category : #conditions }
LcsUpdateActions >> execute: aValue [
	self collection do: [ :eachAction| eachAction execute: aValue ]
]

{ #category : #conditions }
LcsUpdateActions >> execute: aValue context: aDomainObject [
	self collection do: [ :eachAction | eachAction execute: aValue context: aDomainObject ]
	
]

{ #category : #conditions }
LcsUpdateActions >> execute: aValue context: aDomainObject oldValue: anOldValue [
	self collection do: [ :eachAction | eachAction execute: aValue context: aDomainObject oldValue: anOldValue ]
]

{ #category : #'gt views' }
LcsUpdateActions >> gtItemsFor: aView [
	<gtView>
	self collection isNil ifTrue: [ ^ aView empty ].
	^ aView forward
		title: 'Items' translated;
		priority: 0.5;
		object: [ self collection ];
		view: #gtItemsFor:;
		actionUpdateButton
]

{ #category : #comparing }
LcsUpdateActions >> hash [
	^ self collection inject: self identityHash into: [ :each :hash | hash bitXor: each hash ]
]

{ #category : #initialize }
LcsUpdateActions >> initialize [ 
	super initialize.
	self collection: OrderedCollection new
]

{ #category : #testing }
LcsUpdateActions >> isSameAs: anUpdateActions [
	(anUpdateActions isKindOf: LcsUpdateActions) ifFalse: [ ^ false ].
	self collection size = anUpdateActions collection size ifFalse: [ ^ false ].
	self collection with: anUpdateActions collection do: [ :aUpdateAction :bUpdateAction |
		self assert: aUpdateAction description equals: bUpdateAction description. 
		self assert: aUpdateAction actionBlock asString equals: bUpdateAction actionBlock asString ] .
	^ true
]

{ #category : #conditions }
LcsUpdateActions >> removePostUpdateAction: aPostUpdateAction [
	^ self remove: aPostUpdateAction ifAbsent: []
]

{ #category : #'slot model' }
LcsUpdateActions >> slotDefinition [
	^ self parent
]

{ #category : #querying }
LcsUpdateActions >> updateActionWithDescription: aString [
	^ self detect: [ :each | each description = aString ] ifNone: [ ]
]

{ #category : #magritte }
LcsUpdateActions >> updateActionsDescription [
	<magritteDescription>
	^ MAToManyRelationDescription new
		  accessor: #collection;
		  label: 'Post Update Actions';
		  default: #(  );
		  classes: { LcsUpdateAction };
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
		  newItemStencil: [ LcsUpdateAction new
		  						parent: self;
		  						yourself ]
]
