Class {
	#name : #LcsModuleBuilderForm,
	#superclass : #LcsBaseSlotCreationForm,
	#category : #'Lcs-Magritte-Base-Forms - Models'
}

{ #category : #configuration }
LcsModuleBuilderForm class >> builderClass [
	^ LcsModuleBuilderJob
]

{ #category : #magritte }
LcsModuleBuilderForm >> classNamePrefixDescription [
	<magritteDescription>
	^ MAStringDescription new
		label: 'Class Name Prefix';
		priority: 2;
		accessor: (MAChainAccessor accessors: #(slotModelBuilder classPrefix));
		default: '';
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize
				"+ (BrGlamorousWithExplicitContextMenuAptitude
						itemsWithAnchorActions: [ self contextMenuItemsForSuperclass ])" ];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ];
		addCondition: [ :aValue | aValue asString trim size >= 2 ] labelled: 'Enter a unique class prefix name of at least two characters in length';
		addCondition: [ :aValue | aValue asString trim asSymbol allSatisfy: [ :each | each isCharacter ] ] labelled: 'Slot Names can contain only alphas';
		beRequired
]

{ #category : #magritte }
LcsModuleBuilderForm >> classRootNameDescription [
	<magritteDescription>
	^ MAStringDescription new
		label: 'Class Root Name';
		priority: 3;
		accessor: (MAChainAccessor accessors: #(slotModelBuilder classRootName));
		default: '';
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize
				"+ (BrGlamorousWithExplicitContextMenuAptitude
						itemsWithAnchorActions: [ self contextMenuItemsForSuperclass ])" ];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ];
		addCondition: [ :aValue | aValue asString trim size >= 3 ] labelled: 'Enter a unique class prefix name of at least two characters in length';
		addCondition: [ :aValue | aValue asString trim asSymbol allSatisfy: [ :each | each isCharacter ] ] labelled: 'Slot Names can contain only alphas';
		beRequired
]

{ #category : #initialize }
LcsModuleBuilderForm >> initializeOn: aTarget [
	self targetClass: (aTarget isClass ifTrue: [ aTarget ] ifFalse: [ aTarget class ]).
	self slotModelBuilder targetPackageName: ''.
	self slotModelBuilder targetPackageTagName: ''.
	self slotModelBuilder owningModule: self targetClass
]

{ #category : #testing }
LcsModuleBuilderForm >> isSlotModelBuilderNotReified [
	^ self slotModelBuilder class = self builderClass
]

{ #category : #magritte }
LcsModuleBuilderForm >> moduleNameDescription [
	<magritteDescription>
	^ MAStringDescription new
		label: 'Module Name';
		priority: 15;
		accessor: (MAChainAccessor accessors: #(slotModelBuilder moduleName));
		default: '';
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize
				"+ (BrGlamorousWithExplicitContextMenuAptitude
						itemsWithAnchorActions: [ self contextMenuItemsForSuperclass ])" ];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ];
		beRequired
]

{ #category : #'magritte - support' }
LcsModuleBuilderForm >> targetClassLabel [
	^'Install Submodule in:'
]

{ #category : #magritte }
LcsModuleBuilderForm >> targetPackageNameDescription [
	<magritteDescription>
	^ MAStringDescription new
		label: 'Package';
		priority: 8;
		accessor: (MAChainAccessor accessors: #(slotModelBuilder targetPackageName));
		default: '';
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize
				"+ (BrGlamorousWithExplicitContextMenuAptitude
						itemsWithAnchorActions: [ self contextMenuItemsForSuperclass ])" ];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ];
		beRequired
]

{ #category : #magritte }
LcsModuleBuilderForm >> targetPackageTagNameDescription [
	<magritteDescription>
	^ MAStringDescription new
		label: 'Package Tag';
		priority: 9;
		accessor: (MAChainAccessor accessors: #(slotModelBuilder targetPackageTagName));
		default: '';
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize
				"+ (BrGlamorousWithExplicitContextMenuAptitude
						itemsWithAnchorActions: [ self contextMenuItemsForSuperclass ])" ];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ];
		beRequired
]
