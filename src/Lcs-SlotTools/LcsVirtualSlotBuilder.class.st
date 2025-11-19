Class {
	#name : 'LcsVirtualSlotBuilder',
	#superclass : 'LcsBaseSlotBuilder',
	#category : 'Lcs-SlotTools',
	#package : 'Lcs-SlotTools'
}

{ #category : 'configuration' }
LcsVirtualSlotBuilder class >> slotClass [
	"Subclasses can override this method to provide a default"
	^ LcsVirtualSlot
]

{ #category : 'job steps' }
LcsVirtualSlotBuilder >> buildJobSteps [
	self addJobStep: self slotDefinitionMethodBuilder.
	self addJobStep: self getterMethodBuilder
]

{ #category : 'job steps' }
LcsVirtualSlotBuilder >> getterMethodBuilder [
	^ LcsSlotGetterBuilder new
		slotName: self slotName;
		targetClassName: self targetClassName;
		yourself
]

{ #category : 'job steps' }
LcsVirtualSlotBuilder >> slotDefinitionMethodBuilder [
	^ super slotDefinitionMethodBuilder
			beVirtualSlot;
			yourself
]

{ #category : 'accessing' }
LcsVirtualSlotBuilder >> valueAccessor [
	^ self propertyAt: 'valueAccessor'
]

{ #category : 'accessing' }
LcsVirtualSlotBuilder >> valueAccessor: anObject [
	self propertyAt: 'valueAccessor' put: anObject
]

{ #category : 'magritte' }
LcsVirtualSlotBuilder >> valueAccessorDescription [
	<magritteDescription>
	^ MAStringDescription new
		label: 'Internal Selector';
		priority: 8;
		accessor: #valueAccessor;
		default: '';
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize
				"+ (BrGlamorousWithExplicitContextMenuAptitude
						itemsWithAnchorActions: [ self contextMenuItemsForSuperclass ])" ];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ];
"		addCondition: [ :aValue | aValue asString trim size >= 2 ] labelled: 'Enter a unique slot name of at least two characters in length';
		addCondition: [ :aValue | (existingInstvarNames includes: aValue asString trim asSymbol) not ] labelled: 'Slot already exists';
		addCondition: [ :aValue | aValue asString trim asSymbol allSatisfy: [ :each | each isAlphaNumeric ] ] labelled: 'Slot Names can contain only alphanumerics';"
		beRequired
]
