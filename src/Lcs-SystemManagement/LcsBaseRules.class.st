Class {
	#name : 'LcsBaseRules',
	#superclass : 'LcsApplicationObject',
	#traits : 'LtParentTrait + LtOrderedCollection',
	#classTraits : 'LtParentTrait classTrait + LtOrderedCollection classTrait',
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'comparing' }
LcsBaseRules >> = aValidations [
	(aValidations isKindOf: LcsBaseRules) ifFalse: [ ^ false ].
	^ self collection = aValidations collection
]

{ #category : 'conditions' }
LcsBaseRules >> addFirstRule: aRule [
	aRule parent: self.
	^ self collection addFirst: aRule
]

{ #category : 'conditions' }
LcsBaseRules >> addRule: aRule [
	aRule parent: self.
	^ self add: aRule
]

{ #category : 'conditions' }
LcsBaseRules >> addRuleBlock: aBlock description: aString [
	^ self addRule: (
		self ruleClass new
			description: aString;
			conditionBlock: aBlock;
			yourself)
]

{ #category : 'gt views' }
LcsBaseRules >> gtItemsFor: aView [
	<gtView>
	self collection isNil ifTrue: [ ^ aView empty ].
	^ aView forward
		title: 'Items' translated;
		priority: 0.5;
		object: [ self collection ];
		view: #gtItemsFor:;
		actionUpdateButton
]

{ #category : 'testing' }
LcsBaseRules >> hasElements [
	^ self isNotEmpty
]

{ #category : 'testing' }
LcsBaseRules >> hasNoElements [
	^ self isEmpty
]

{ #category : 'comparing' }
LcsBaseRules >> hash [
	^ self collection inject: self identityHash into: [ :each :hash | hash bitXor: each hash ]
]

{ #category : 'initialize' }
LcsBaseRules >> initialize [ 
	super initialize.
	self collection: OrderedCollection new
]

{ #category : 'initialize' }
LcsBaseRules >> initializeOn: anObject [ 
	self parent: anObject
]

{ #category : 'conditions' }
LcsBaseRules >> removeRule: aRule [
	^ self remove: aRule ifAbsent: []
]

{ #category : 'conditions' }
LcsBaseRules >> removeRuleWithDescription: aDescription [
	| rule |
	rule := self detect: [ :each | each description = aDescription ] ifNone: [ nil ].
	^ rule ifNotNil: [ self removeRule: rule ]
]

{ #category : 'conditions' }
LcsBaseRules >> ruleClass [
	^ self subclassResponsibility
]

{ #category : 'querying' }
LcsBaseRules >> ruleWithDescription: aString [
	^ self detect: [ :each | each description = aString ] ifNone: [ ]
]

{ #category : 'slot model' }
LcsBaseRules >> slotDefinition [
	^ self parent
]

{ #category : 'gt views' }
LcsBaseRules >> slotPropertiesViewItems [
	^ self collection collect: [ :each | LcsSlotPropertyViewItem newLabel: '' item: each ]
]

{ #category : 'validations' }
LcsBaseRules >> validate: aValue [
	^ self validate: aValue context: nil
]

{ #category : 'validations' }
LcsBaseRules >> validate: aValue context: aDomainObject [
	^ self validate: aValue context: aDomainObject oldValue: nil
]

{ #category : 'validations' }
LcsBaseRules >> validate: aValue context: aDomainObject oldValue: anOldValue [
	self collection do: [ :eachValidation | eachValidation validate: aValue context: aDomainObject oldValue: anOldValue ].
	^ true
]

{ #category : 'validations' }
LcsBaseRules >> validate: aValue withValidator: aValidator [
	self collection do: [ :eachValidation | 
		eachValidation validate: aValue context: nil oldValue: nil ]
]

{ #category : 'magritte' }
LcsBaseRules >> validationRulesDescriptionClasses [
	self subclassResponsibility
]

{ #category : 'magritte' }
LcsBaseRules >> validationsRulesDescription [
	<magritteDescription>
	^ MAToManyRelationDescription new
		  accessor: #collection;
		  label: 'Validation Rules';
		  default: #(  );
		  classes: self validationRulesDescriptionClasses;
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
		  newItemStencil: [ LcsValidationRule new
		  						parent: self;
		  						yourself ]
]
