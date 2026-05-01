Class {
	#name : 'LcsVirtualSlotBuilder',
	#superclass : 'LcsBaseSlotBuilder',
	#category : 'Lcs-SlotTools-Core',
	#package : 'Lcs-SlotTools',
	#tag : 'Core'
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

{ #category : 'accessing' }
LcsVirtualSlotBuilder >> computedValueAccessor [
	^ self propertyAt: 'valueAccessor'
]

{ #category : 'accessing' }
LcsVirtualSlotBuilder >> computedValueAccessor: anObject [
	self propertyAt: 'valueAccessor' put: anObject
]

{ #category : 'magritte' }
LcsVirtualSlotBuilder >> computedValueAccessorDescription [
	<magritteDescription>
	^ MAStringDescription new
		label: 'Internal Selector';
		priority: 8;
		accessor: #computedValueAccessor;
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
