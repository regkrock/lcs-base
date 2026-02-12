Class {
	#name : 'LcsFacadeSlotBuilder',
	#superclass : 'LcsAccessorSlotBuilder',
	#category : 'Lcs-SlotTools-Core',
	#package : 'Lcs-SlotTools',
	#tag : 'Core'
}

{ #category : 'configuration' }
LcsFacadeSlotBuilder class >> slotClass [
	^ LcsFacadeSlot
]

{ #category : 'initialize' }
LcsFacadeSlotBuilder >> initialize [
	super initialize.
	self targetSlotPath: OrderedCollection new
]

{ #category : 'property' }
LcsFacadeSlotBuilder >> targetSlotPath [
	^ self propertyAt: 'targetSlotPath'
]

{ #category : 'property' }
LcsFacadeSlotBuilder >> targetSlotPath: aString [
	^ self propertyAt: 'targetSlotPath' put: aString
]

{ #category : 'magritte' }
LcsFacadeSlotBuilder >> targetSlotPathDescription [
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
