Class {
	#name : #LcsValidationConditions,
	#superclass : #LcsApplicationObject,
	#traits : 'LtParentTrait + LtOrderedCollection',
	#classTraits : 'LtParentTrait classTrait + LtOrderedCollection classTrait',
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #'hashing\t' }
LcsValidationConditions >> = aValidationCollections [
	(aValidationCollections isKindOf: LcsValidationConditions) ifFalse: [ ^ false ].
	"self collection size = aValidationCollections collections size ifFalse: [ ^ false ]."
	^ self collection = aValidationCollections collection
]

{ #category : #conditions }
LcsValidationConditions >> addValidationCondition: aValidationCondition [
	aValidationCondition parent: self.
	^ self add: aValidationCondition
]

{ #category : #conditions }
LcsValidationConditions >> addValidationCondition: aBlock description: aString [
	self addValidationCondition: (
		LcsValidationCondition new
			validationDescription: aString;
			conditionBlock: aBlock;
			yourself)
]

{ #category : #'hashing\t' }
LcsValidationConditions >> hash [
	^ self collection inject: self identityHash into: [ :each :hash | hash bitXor: each hash ]
]

{ #category : #initialize }
LcsValidationConditions >> initialize [ 
	super initialize.
	self collection: OrderedCollection new
]

{ #category : #conditions }
LcsValidationConditions >> removeValidationCondition: aCondition [
	^ self remove: aCondition ifAbsent: []
]

{ #category : #conditions }
LcsValidationConditions >> removeValidationConditionWithDescription: aDescription [
	| condition |
	condition := self detect: [ :each | each validationDescription = aDescription ] ifNone: [ nil ].
	^ condition ifNotNil: [ self removeValidationCondition: condition ]
]

{ #category : #'slot model' }
LcsValidationConditions >> slotDefinition [
	^ self parent
]

{ #category : #conditions }
LcsValidationConditions >> validate: aValue [
	self collection do: [ :eachCondition | eachCondition validate: aValue ]
]

{ #category : #conditions }
LcsValidationConditions >> validate: aValue context: aDomainObject [
	self collection do: [ :eachCondition | eachCondition validate: aValue context: aDomainObject ]
	
]

{ #category : #conditions }
LcsValidationConditions >> validate: aValue withValidator: aValidator [
	self collection do: [ :eachCondition | 
		[ eachCondition validate: aValue ]
			on: LcsSlotValidationError
			do: [ :s | 
				aValidator errorDescriptions add: eachCondition validationDescription.
				s return: nil ] ]
]

{ #category : #querying }
LcsValidationConditions >> validationConditionWithDescription: aString [
	^ self detect: [ :each | each validationDescription = aString ] ifNone: [ ]
]

{ #category : #magritte }
LcsValidationConditions >> validationConditionsDescription [
	<magritteDescription>
	^ MAToManyRelationDescription new
		  accessor: #collection;
		  label: 'Validation Conditions';
		  default: #(  );
		  classes: { LcsValidationCondition };
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
		  newItemStencil: [ LcsValidationCondition new
		  						parent: self;
		  						yourself ]
]
