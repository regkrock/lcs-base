Class {
	#name : 'LcsDelegatorSlot',
	#superclass : 'LcsFacadeSlot',
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'gt views' }
LcsDelegatorSlot >> addAssociationsToUmlModel: aUmlModel [
	super addAssociationsToUmlModel: aUmlModel.
	aUmlModel
		addAssociation: self slotName
			from: self domainClass
			to: self slotTypes first
]

{ #category : 'gt views' }
LcsDelegatorSlot >> addClassesToUmlModel: umlModel [ 
	super addClassesToUmlModel: umlModel.
	umlModel addClassNamed: self slotTypes first
]

{ #category : 'slot access' }
LcsDelegatorSlot >> currentSlotVarIn: aTargetDomainObject [
	| actualDomainObject |
	actualDomainObject := aTargetDomainObject.
	self targetSlotPath
		do: [ :each | actualDomainObject := actualDomainObject perform: each asSymbol ].
	^ actualDomainObject
]

{ #category : 'magritte' }
LcsDelegatorSlot >> initialValueBlockDescription [
	<magritteDescription>
	^ nil
]

{ #category : 'initialize' }
LcsDelegatorSlot >> initialize [
	super initialize.
	self targetSlotPath: OrderedCollection new
]

{ #category : 'slot access' }
LcsDelegatorSlot >> slotVarPut: anObject in: aTargetDomainObject [
	| actualDomainObject |
	actualDomainObject := aTargetDomainObject.
	(self targetSlotPath copyFrom: 1 to: (self targetSlotPath size - 1)) do: [ :each |
		actualDomainObject := actualDomainObject perform: each asSymbol ].
	actualDomainObject
		slotVarNamed: self targetSlotPath last
		put: anObject
]

{ #category : 'properties' }
LcsDelegatorSlot >> targetSlotPath [
	^ self properties at: 'targetSlotPath'
]

{ #category : 'properties' }
LcsDelegatorSlot >> targetSlotPath: aSlotNamesCollection [ 
	self properties at: 'targetSlotPath' put: aSlotNamesCollection asOrderedCollection
]

{ #category : 'magritte' }
LcsDelegatorSlot >> targetSlotPathDescription [
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
