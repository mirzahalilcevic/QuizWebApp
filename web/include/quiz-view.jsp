<%@ page import="qwa.domain.Quiz" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!-- Quiz Home-->
<div class="card card-cascade wider quiz-home">

    <!-- Image -->
    <div class="view view-cascade overlay">
        <img class="card-img-top" src="https://mdbootstrap.com/img/Photos/Others/photo6.jpg"
             alt="quiz image">
    </div>

    <!-- Info -->
    <div class="card-body card-body-cascade text-center">

        <!-- Name -->
        <h4 class="card-title quiz-name"><strong>
            <%=((Quiz) request.getAttribute("quiz")).getName()%>
        </strong></h4>

        <!-- Description -->
        <p class="card-text quiz-desc">
            <%=((Quiz) request.getAttribute("quiz")).getDescription()%>
        </p>

        <br>

        <!-- Start -->
        <button type="button" class="btn btn-outline-yellow btn-rounded waves-effect start-button">
            Start
        </button>

    </div>
</div>
<!-- Quiz Home -->

<!-- Quiz Question -->
<div class="card quiz-question" style="display: none">
    <div class="card-body card-body-cascade">

        <!-- Question -->
        <h5 class="card-header question-text">Question text</h5>

        <!-- Answers -->
        <div class="form-check question-answers checkbox-custom">
            <br>
            <input type="checkbox" class="form-check-input answer-0"
                   id="checkbox1<%=((Quiz) request.getAttribute("quiz")).getId()%>">
            <label class="form-check-label answer-label-0"
                   for="checkbox1<%=((Quiz) request.getAttribute("quiz")).getId()%>">Answer 1</label>
            <br>
            <input type="checkbox" class="form-check-input answer-1"
                   id="checkbox2<%=((Quiz) request.getAttribute("quiz")).getId()%>">
            <label class="form-check-label answer-label-1"
                   for="checkbox2<%=((Quiz) request.getAttribute("quiz")).getId()%>">Answer 2</label>
            <br>
            <input type="checkbox" class="form-check-input answer-2"
                   id="checkbox3<%=((Quiz) request.getAttribute("quiz")).getId()%>">
            <label class="form-check-label answer-label-2"
                   for="checkbox3<%=((Quiz) request.getAttribute("quiz")).getId()%>">Answer 3</label>
            <br>
            <input type="checkbox" class="form-check-input answer-3"
                   id="checkbox4<%=((Quiz) request.getAttribute("quiz")).getId()%>">
            <label class="form-check-label answer-label-3"
                   for="checkbox4<%=((Quiz) request.getAttribute("quiz")).getId()%>">Answer 4</label>
            <br>
            <input type="checkbox" class="form-check-input answer-4"
                   id="checkbox5<%=((Quiz) request.getAttribute("quiz")).getId()%>">
            <label class="form-check-label answer-label-4"
                   for="checkbox5<%=((Quiz) request.getAttribute("quiz")).getId()%>">Answer 5</label>
        </div>

        <!-- Controls -->
        <p class="card-text text-right">
            <br>
            <!-- Next -->
            <button type="button" class="btn btn-sm btn-outline-yellow btn-rounded waves-effect next-button"
                    disabled>
                Next
            </button>
            <!-- Skip -->
            <button type="button"
                    class="btn btn-sm btn-outline-yellow btn-rounded waves-effect skip-button">
                Skip
            </button>
        </p>

        <!-- Progress -->
        <div class="progress md-progress time-progress" style="height: 20px">
            <div class="progress-bar progress-bar-striped progress-bar-animated bg-success time-progress-bar"
                 role="progressbar" style="width: 100%; height: 20px" aria-valuenow="0" aria-valuemin="0"
                 aria-valuemax="100">
                60s
            </div>
        </div>

        <!-- Counter -->
        <div class="card-footer text-muted text-center question-counter">1/10</div>

    </div>
</div>
<!-- Quiz Question -->

<!-- Quiz Skipped -->
<div class="card quiz-skipped" style="display: none">
    <div class="card-body card-body-cascade text-center">

        <h4 class="card-title"><strong>Skipped questions</strong></h4>

        <!-- Skipped -->
        <div class="list-group skipped-questions">
            <button type="button"
                    class="list-group-item list-group-item-action waves-effect d-flex justify-content-between align-items-center"
                    title="Tooltip">
                <span class="d-inline-block text-truncate">Skipped question</span>&nbsp;&nbsp;
                <span class="badge badge-success badge-pill">50s</span>
            </button>
        </div>

    </div>
</div>
<!-- Quiz Skipped -->

<!-- Quiz Summary -->
<div class="card quiz-summary" style="display: none">
    <div class="card-body card-body-cascade text-center">

        <!-- Result -->
        <span class="min-chart summary-chart" data-percent="100"><span
                class="percent"></span></span>
        <h5><span class="label success-color badge summary-badge">
                        <span class="summary-correct">correct/num</span> <i class="fas fa-check"></i> &nbsp;
                        <span class="summary-points">score/total</span> points</span></h5>

        <br>

        <!-- Form -->
        <form class="text-center">

            <div class="form-row">
                <div class="col">
                    <!-- First name -->
                    <div class="md-form">
                        <input type="text" id="input1<%=((Quiz) request.getAttribute("quiz")).getId()%>"
                               class="form-control first-name text-white">
                        <label for="input1<%=((Quiz) request.getAttribute("quiz")).getId()%>">First name</label>
                    </div>
                </div>
                <div class="col">
                    <!-- Last name -->
                    <div class="md-form">
                        <input type="text" id="input2<%=((Quiz) request.getAttribute("quiz")).getId()%>"
                               class="form-control last-name text-white">
                        <label for="input2<%=((Quiz) request.getAttribute("quiz")).getId()%>">Last name</label>
                    </div>
                </div>
            </div>

            <!-- E-mail -->
            <div class="md-form mt-0">
                <input type="text" id="input3<%=((Quiz) request.getAttribute("quiz")).getId()%>"
                       class="form-control email text-white">
                <label for="input3<%=((Quiz) request.getAttribute("quiz")).getId()%>">E-mail</label>
            </div>

            <!-- Send button -->
            <button type="button"
                    class="btn blue-gradient btn-rounded btn-block my-4 waves-effect z-depth-0 submit-button">
                Send
            </button>

        </form>

    </div>
</div>
<!-- Quiz Summary -->
