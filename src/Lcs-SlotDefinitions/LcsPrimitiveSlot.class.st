Class {
	#name : #LcsPrimitiveSlot,
	#superclass : #LcsSlotDefintion,
	#category : #'Lcs-SlotDefinitions'
}

{ #category : #default }
LcsPrimitiveSlot >> defaultInitialValueBlock [
	^ [ self defaultInitialValue ]
]

{ #category : #'gt view' }
LcsPrimitiveSlot >> gtSlotDefinitionAttributes [
	^ super gtSlotDefinitionAttributes
		add: 'initialValueBlock' -> self initialValueBlock;
		add: 'initialValue' -> initialValueBlock value;
		yourself
]

{ #category : #accessing }
LcsPrimitiveSlot >> initialValueFor: aDomainObject [
	^ self initialValueBlock cull: aDomainObject class
]

{ #category : #initialization }
LcsPrimitiveSlot >> initialize [
	super initialize.
	self addSlotType: self typeClass
]

{ #category : #accessing }
LcsPrimitiveSlot >> initializeSlotValueIn: aDomainObject [
	self setValueTo: (self initialValueFor: aDomainObject) in: aDomainObject
]

{ #category : #configuration }
LcsPrimitiveSlot >> typeClass [
	self subclassResponsibility
]
