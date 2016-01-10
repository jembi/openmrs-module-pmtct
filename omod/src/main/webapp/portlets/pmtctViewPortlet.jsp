<%@ include file="/WEB-INF/template/include.jsp"%>
<%@ taglib prefix="pmtcttag" uri="/WEB-INF/view/module/pmtct/taglibs/pmtcttag.tld" %>
<openmrs:htmlInclude file="/moduleResources/pmtct/pmtctstyle.css" />

<b class="boxHeader"><spring:message code="pmtct.overviewBoxTitle" /></b>
<c:if test="${pmtctModuleConfigured=='false'}">
	<div class="box">
		<span class="error"><spring:message code="pmtct.config.configurationNotDone"/></span><br/><br/>
		&rArr;&nbsp;<a href="module/pmtct/config.htm"><spring:message code="pmtct.config.configureModule"/></a>
	</div>
</c:if>

<c:if test="${pmtctModuleConfigured=='true'}">
<div class="box">
	<c:if test="${pmtctObjects.patient.gender == 'F' && pmtctObjects.isInTheProgram != '0'  && pmtctObjects.patient.age>pmtctObjects.maxAgeOfChildInPMTCT}">
	<div style="float: left; width: 20%;">
		<div id="list">
			<c:forEach items="${pmtctprogram}" var="p">
				
				<c:if test="${p.dateCompleted==null}">
					<h3 class="currentProgram"><openmrs:formatDate date="${p.dateEnrolled}"/> - <spring:message code="pmtct.general.now"/></h3>
					<p>
						<openmrs:hasPrivilege privilege='Add ANC and follow-up information'>						
							<c:if test="${pmtcttag:currentEncounterId(pmtctObjects.cpnencs,p.dateEnrolled)==''}">
								&rArr;&nbsp;<a href="module/pmtct/addCPNInfoForm.form?patientId=${pmtctObjects.patient.patientId}"><spring:message code="pmtct.portlet.addCPNInfo" /></a>
								<br />
							</c:if>
						</openmrs:hasPrivilege>
						
						<openmrs:hasPrivilege privilege='View PMTCT patients in ANC'>
							<c:if test="${pmtcttag:currentEncounterId(pmtctObjects.cpnencs,p.dateEnrolled)!=''}">
								<img border="0" src="${pageContext.request.contextPath}/images/checkmark.png"/><a href="module/pmtct/viewCPNInfo.htm?patientId=${pmtctObjects.patient.patientId}&encounterId=${pmtcttag:currentEncounterId(pmtctObjects.cpnencs,p.dateEnrolled)}"><spring:message code="pmtct.portlet.viewCPNInfo" /></a>
								 <br />
							</c:if>
						</openmrs:hasPrivilege>
							
						<openmrs:hasPrivilege privilege='Add ANC and follow-up information'>
							&rArr;&nbsp;<a href="module/pmtct/followupMotherForm.form?patientId=${pmtctObjects.patient.patientId}&edit=${p.dateCompleted==null}"><spring:message code="pmtct.portlet.addFollowupMotherInfo" /></a>
							<br />
						</openmrs:hasPrivilege>
						
						<openmrs:hasPrivilege privilege='Add Maternity information'>
							<c:if test="${pmtcttag:currentEncounterId(pmtctObjects.maternityencs,p.dateEnrolled)==''}">
								&rArr;&nbsp;<a href="module/pmtct/addMaternityForm.form?patientId=${pmtctObjects.patient.patientId}"><spring:message code="pmtct.portlet.addMaternityInfo" /></a>
								<br />
							</c:if>
						</openmrs:hasPrivilege>
						
						<openmrs:hasPrivilege privilege='View PMTCT patients in maternity'>
							<c:if test="${pmtcttag:currentEncounterId(pmtctObjects.maternityencs,p.dateEnrolled)!=''}">
								<img border="0" src="${pageContext.request.contextPath}/images/checkmark.png"/><a href="module/pmtct/viewMaternityInfo.htm?patientId=${pmtctObjects.patient.patientId}&encounterId=${pmtcttag:currentEncounterId(pmtctObjects.maternityencs,p.dateEnrolled)}"><spring:message code="pmtct.portlet.viewMaternityInfo" /></a>
								<br/>
							</c:if>
						</openmrs:hasPrivilege>
						
						<openmrs:hasPrivilege privilege='View PMTCT flowsheet'>
							<br />
							**&nbsp;<a href="module/pmtct/pmtctFlowsheet.list?patientId=${pmtctObjects.patient.patientId}"><b><spring:message code="pmtct.portlet.flowsheet" /></b></a>
						</openmrs:hasPrivilege>
					</p>
				</c:if>
				
				<c:if test="${p.dateCompleted!=null}">
					<h3 class="completedProgram"><openmrs:formatDate date="${p.dateEnrolled}"/> - <openmrs:formatDate date="${p.dateCompleted}"/></h3>
					<p>
						<openmrs:hasPrivilege privilege='View PMTCT patients in ANC'>
							<c:if test="${pmtcttag:encounterId(pmtctObjects.cpnencs,p.dateEnrolled,p.dateCompleted)!=''}">
								<img border="0" src="${pageContext.request.contextPath}/images/checkmark.png"/>&nbsp;<a href="module/pmtct/viewCPNInfo.htm?patientId=${pmtctObjects.patient.patientId}&encounterId=${pmtcttag:encounterId(pmtctObjects.cpnencs,p.dateEnrolled,p.dateCompleted)}"><spring:message code="pmtct.portlet.viewCPNInfo" /></a>
								<br />
							</c:if>
							
							<img border="0" src="${pageContext.request.contextPath}/images/checkmark.png"/>&nbsp;<a href="module/pmtct/followupMotherForm.form?patientId=${pmtctObjects.patient.patientId}&edit=${p.dateCompleted==null}"><spring:message code="pmtct.portlet.viewFollowupMotherInfo" /></a>
							<br />
						</openmrs:hasPrivilege>
						
						<openmrs:hasPrivilege privilege='View PMTCT patients in maternity'>
							<c:if test="${pmtcttag:encounterId(pmtctObjects.maternityencs,p.dateEnrolled,p.dateCompleted)!=''}">
								<img border="0" src="${pageContext.request.contextPath}/images/checkmark.png"/>&nbsp;<a href="module/pmtct/viewMaternityInfo.htm?patientId=${pmtctObjects.patient.patientId}&encounterId=${pmtcttag:encounterId(pmtctObjects.maternityencs,p.dateEnrolled,p.dateCompleted)}"><spring:message code="pmtct.portlet.viewMaternityInfo" /></a>
								<br/>
							</c:if>
						</openmrs:hasPrivilege>
						
						<openmrs:hasPrivilege privilege='View PMTCT flowsheet'>
							<br/>
							**&nbsp;<a href="module/pmtct/pmtctFlowsheet.list?patientId=${pmtctObjects.patient.patientId}"><b><spring:message code="pmtct.portlet.flowsheet" /></b></a>
						</openmrs:hasPrivilege>
					</p>
				</c:if>
				
			</c:forEach>		
		</div>
	</div>
	<div style="float: right; width: 78%; -moz-border-radius: 4px; border: 1px solid navy; padding: 0.4em; display: none;">
		<h3 class="currentProgram titlePortlet">Upcomming visits</h3>
		<p style="margin: 3px auto 2px 10px;">
			<c:forEach items="1,2,3" var="val">
				Visit-${val}.<br/>
			</c:forEach>
		</p>
		<br/>
		<h3 class="currentProgram titlePortlet">Related encounters</h3>
		<p style="margin: 3px auto 2px 10px;">
			<table>
				<c:forEach items="${pmtctObjects.cpnencs}" var="cpnEnc">
					<tr><td>${cpnEnc.encounterType}</td><td>${cpnEnc.provider}</td><td>${cpnEnc.encounterDatetime}</td><td>${cpnEnc.location}</td></tr>
				</c:forEach>
				<c:forEach items="${pmtctObjects.maternityencs}" var="matEnc">
					<tr><td>${matEnc.encounterType}</td><td>${matEnc.provider}</td><td>${matEnc.encounterDatetime}</td><td>${matEnc.location}</td></tr>
				</c:forEach>
				<c:forEach items="${pmtctObjects.motherfollowupencs}" var="mfEnc">
					<tr><td>${mfEnc.encounterType}</td><td>${mfEnc.provider}</td><td>${mfEnc.encounterDatetime}</td><td>${mfEnc.location}</td></tr>
				</c:forEach>
				<c:forEach items="${pmtctObjects.pmtctPCREnc}" var="pcrEnc">
					<tr><td>${pcrEnc.encounterType}</td><td>${pcrEnc.provider}</td><td>${pcrEnc.encounterDatetime}</td><td>${pcrEnc.location}</td></tr>
				</c:forEach>
				<c:forEach items="${pmtctObjects.pmtctSerology9Enc}" var="ser9Enc">
					<tr><td>${ser9Enc.encounterType}</td><td>${ser9Enc.provider}</td><td>${ser9Enc.encounterDatetime}</td><td>${ser9Enc.location}</td></tr>
				</c:forEach>
				<c:forEach items="${pmtctObjects.pmtctSerology18Enc}" var="ser18Enc">
					<tr><td>${ser18Enc.encounterType}</td><td>${ser18Enc.provider}</td><td>${ser18Enc.encounterDatetime}</td><td>${ser18Enc.location}</td></tr>
				</c:forEach>
			</table>
		</p>
	</div>
	<div style="clear: both;"></div>
	</c:if> 
	
	<c:if test="${pmtctObjects.isInTheProgram != '0'  && pmtctObjects.patient.age<=pmtctObjects.maxAgeOfChildInPMTCT}">
	<div style="float: left; width: 20%;">
		<div id="list">
			<c:forEach items="${pmtctprogram}" var="p">
				
				
				<c:if test="${p.dateCompleted==null}">
					<h3 class="currentProgram"><openmrs:formatDate date="${p.dateEnrolled}"/> - <spring:message code="pmtct.general.now"/></h3>
					<p>	
						<openmrs:hasPrivilege privilege='Add Pediatric tests information'>
							&rArr;&nbsp;<a href="module/pmtct/childTestForm.form?patientId=${pmtctObjects.patient.patientId}&encounterType=${pmtctObjects.currentTest}"><spring:message code="pmtct.portlet.addChildTestInfo" /></a>
							<br/>
						</openmrs:hasPrivilege>
						
						<openmrs:hasPrivilege privilege='View PMTCT flowsheet'>
							<br/>
							**&nbsp;<a href="module/pmtct/pmtctFlowsheet.list?patientId=${pmtctObjects.patient.patientId}"><b><spring:message code="pmtct.portlet.flowsheet" /></b></a>
						</openmrs:hasPrivilege>
					</p>
				</c:if>
				
				<c:if test="${p.dateCompleted!=null}">
					<h3 class="currentProgram"><openmrs:formatDate date="${p.dateEnrolled}"/> - <openmrs:formatDate date="${p.dateCompleted}"/></h3>
					<p>
						<openmrs:hasPrivilege privilege='View PMTCT pediatric tests'>				
							<img border="0" src="${pageContext.request.contextPath}/images/checkmark.png"/>&nbsp;<a href="module/pmtct/childTestForm.form?patientId=${pmtctObjects.patient.patientId}&encounterType=${pmtctObjects.currentTest}"><spring:message code="pmtct.portlet.addChildTestInfo" /></a>
							<br/>
						</openmrs:hasPrivilege>
						
						<openmrs:hasPrivilege privilege='View PMTCT flowsheet'>
							<br/>
							**&nbsp;<a href="module/pmtct/pmtctFlowsheet.list?patientId=${pmtctObjects.patient.patientId}"><b><spring:message code="pmtct.portlet.flowsheet" /></b></a>
						</openmrs:hasPrivilege>						
					</p>
				</c:if>
				
			</c:forEach>		
		</div>
	</div>
	<div style="float: right; width: 78%; -moz-border-radius: 4px; border: 1px solid navy; padding: 0.4em; display: none;">
		<h3 class="currentProgram titlePortlet">Upcomming visits</h3>
		<p style="margin: 3px auto 2px 10px;">
			<c:forEach items="1,2,3" var="val">
				Visit-${val}.<br/>
			</c:forEach>
		</p>	
		<br/>
		<h3 class="currentProgram titlePortlet">Related encounters</h3>
		<p style="margin: 3px auto 2px 10px;">
			<table>
				<c:forEach items="${pmtctObjects.cpnencs}" var="cpnEnc">
					<tr><td>${cpnEnc.encounterType}</td><td>${cpnEnc.provider}</td><td>${cpnEnc.encounterDatetime}</td><td>${cpnEnc.location}</td></tr>
				</c:forEach>
				<c:forEach items="${pmtctObjects.maternityencs}" var="matEnc">
					<tr><td>${matEnc.encounterType}</td><td>${matEnc.provider}</td><td>${matEnc.encounterDatetime}</td><td>${matEnc.location}</td></tr>
				</c:forEach>
				<c:forEach items="${pmtctObjects.motherfollowupencs}" var="mfEnc">
					<tr><td>${mfEnc.encounterType}</td><td>${mfEnc.provider}</td><td>${mfEnc.encounterDatetime}</td><td>${mfEnc.location}</td></tr>
				</c:forEach>
				<c:forEach items="${pmtctObjects.pmtctPCREnc}" var="pcrEnc">
					<tr><td>${pcrEnc.encounterType}</td><td>${pcrEnc.provider}</td><td>${pcrEnc.encounterDatetime}</td><td>${pcrEnc.location}</td></tr>
				</c:forEach>
				<c:forEach items="${pmtctObjects.pmtctSerology9Enc}" var="ser9Enc">
					<tr><td>${ser9Enc.encounterType}</td><td>${ser9Enc.provider}</td><td>${ser9Enc.encounterDatetime}</td><td>${ser9Enc.location}</td></tr>
				</c:forEach>
				<c:forEach items="${pmtctObjects.pmtctSerology18Enc}" var="ser18Enc">
					<tr><td>${ser18Enc.encounterType}</td><td>${ser18Enc.provider}</td><td>${ser18Enc.encounterDatetime}</td><td>${ser18Enc.location}</td></tr>
				</c:forEach>
			</table>
		</p>
	</div>
	<div style="clear: both;"></div>
	</c:if> 
	
	<c:if test="${pmtctObjects.isInTheProgram == '0' && pmtctObjects.patient.gender =='F'}">
		<!-- <spring:message code="pmtct.general.error.she_is_not_in_pmtct_program" /> -->
		<script type="text/javascript">
			document.getElementById("pmtctTab").style.display="none";
			document.getElementById("pmtct.pmtct").style.display="none";
		</script>
	</c:if>
	
	<c:if test="${pmtctObjects.patient.gender == 'M' && pmtctObjects.patient.age>pmtctObjects.maxAgeOfChildInPMTCT}">
		<!-- <spring:message code="pmtct.general.error.pmtctinfodonotdisplay_male" /> -->
		<script type="text/javascript">
			document.getElementById("pmtctTab").style.display="none";
			document.getElementById("pmtct.pmtct").style.display="none";
		</script>
	</c:if>
	
</div>
</c:if>