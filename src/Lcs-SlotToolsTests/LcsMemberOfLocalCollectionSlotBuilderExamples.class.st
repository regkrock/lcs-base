Class {
	#name : 'LcsMemberOfLocalCollectionSlotBuilderExamples',
	#superclass : 'LcsExamples',
	#category : 'Lcs-SlotToolsTests-Examples',
	#package : 'Lcs-SlotToolsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LcsMemberOfLocalCollectionSlotBuilderExamples >> localMemberSlotBuilder [
	<gtExample>
	| builder |
	builder := self newBuilder.
	builder
		targetClassName: 'LxxInvoice';
		slotName: 'parent';
		collectionSlotName: 'invoiceItems';
		"collectionClassName: #LxxInvoiceItem;"
		addSlotType: 'LxxInvoiceItems'.
	builder buildJobSteps.
	^ builder
]

{ #category : 'tests' }
LcsMemberOfLocalCollectionSlotBuilderExamples >> memberOfLocalCollectionSlotAddedToConnectInvoiceItemWithInvoiceItemsInInvoice [
	<gtExample>
	| invoiceBuilderJob invoiceItemBuilderJob builder |
	self ensureCurrentSystemIsPrototypeSystem.
	self currentSystem clearUnitOfWork.
	invoiceBuilderJob := LcsDomainClassAndGlobalCollectionClassBuilderJobExamples new 
							invoiceAndInvoicesBuilderJob.
	invoiceItemBuilderJob := LcsDomainClassAndLocalCollectionClassBuilderJobExamples new
							 	invoiceItemAndLocalInvoiceItemsCreationJobWithoutInoiceItemsSlotInInvoice.
	builder := self localMemberSlotBuilder.
	[
		invoiceBuilderJob execute.
		invoiceBuilderJob verifyCodeInstallation.
		invoiceItemBuilderJob execute.
		invoiceItemBuilderJob verifyCodeInstallation.
		self denyClass: 'LxxInvoice' hasLocalSelector: #invoiceItems.
		self denyClass: 'LxxInvoiceItem' hasLocalClassSelector: #parentSlotDefinition.
		builder execute.
		builder verifyCodeInstallation.
		"self verifyInvoiceItemCreation" ]
		ensure: [
			builder uninstall.
			builder verifyUninstall.
			invoiceItemBuilderJob uninstall.
			invoiceItemBuilderJob verifyUninstall.
			invoiceBuilderJob uninstall.
			invoiceBuilderJob verifyUninstall ]
]

{ #category : 'examples' }
LcsMemberOfLocalCollectionSlotBuilderExamples >> newBuilder [
	<gtExample>
	| builder |
	builder := LcsMemberOfLocalCollectionSlotBuilder new.
	^ builder
]

{ #category : 'validation' }
LcsMemberOfLocalCollectionSlotBuilderExamples >> verifyInvoiceItemCreation [
		"| invoice invoiceItem |
		self denyClass: 'LxxInvoice' hasLocalSelector: #invoiceItems."
		self assertClass: 'LxxInvoiceItem' hasLocalClassSelector: #parentSlotDefinition.
		"self assert: (invoice := 'LxxInvoice' asClass new invoiceItems isEmpty ).
		invoiceItem := #LxxInvoiceItem asClass new"
]
